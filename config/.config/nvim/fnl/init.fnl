(local unpack (or table.unpack _G.unpack))
(local fmt string.format)

(fn nnoremap [from to]
  (vim.cmd (fmt "nnoremap %s %s" from to)))

(nnoremap "gD"         "<cmd>lua vim.lsp.buf.declaration()<CR>")
(nnoremap "gd"         "<cmd>lua vim.lsp.buf.definition()<CR>")
(nnoremap "K"          "<cmd>lua vim.lsp.buf.hover()<CR>")
(nnoremap "gi"         "<cmd>lua vim.lsp.buf.implementation()<CR>")
(nnoremap "<C-k>"      "<cmd>lua vim.lsp.buf.signature_help()<CR>")
(nnoremap "<leader>wa" "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
(nnoremap "<leader>wr" "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")
(nnoremap "<leader>wl" "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
(nnoremap "<leader>D"  "<cmd>lua vim.lsp.buf.type_definition()<CR>")
(nnoremap "<leader>rn" "<cmd>lua vim.lsp.buf.rename()<CR>")
(nnoremap "<leader>ca" "<cmd>lua vim.lsp.buf.code_action()<CR>")
(nnoremap "gr"         "<cmd>lua vim.lsp.buf.references()<CR>")
(nnoremap "<leader>e"  "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")
(nnoremap "<c-k>"      "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
(nnoremap "<c-j>"      "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
(nnoremap "<leader>q"  "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>")

(fn map [f tbl]
  (let [t []]
    (each [_ v (ipairs tbl)]
      (table.insert t (f v)))
    t))

(fn max [x y ...]
  (if (= (type x) :table)
    (max (unpack x))
    (let [greater (if (> x y) x y)]
      (if (= (length [...]) 0)
        greater
        (max greater ...)))))

(fn min [x y ...]
  "Find minimal value."
  (if (= (type x) :table)
    (min (unpack x))
    (let [smaller (if (< x y) x y)]
      (if (= (length [...]) 0)
        smaller
        (min smaller ...)))))

(fn split-string [str sep]
  (let [t []]
    (each [token (string.gmatch str (or sep "([^%s]+)" ))]
      (table.insert t token)) t))

(fn change-font-size [delta]
  (let [tokens (split-string vim.o.guifont "[^:][^h]+")
        font-height  (min 50 (max 5 (+ (string.sub (. tokens (length tokens)) 2) delta))) 
        font-name (. tokens 1)]
    (set vim.o.guifont  (.. font-name ":h"  font-height))))

(fn _G.decrease_font []
  (change-font-size -2))

(fn _G.increase_font []
  (change-font-size 2))

(fn _G.ToggleTerm [height]
  (let [buffer-id (vim.fn.bufnr :term)
        window-id (. (vim.fn.win_findbuf buffer-id) 1)]
    (if window-id
      (vim.cmd :hide)
      (do (vim.cmd :split)
        (if (= buffer-id -1)
          (vim.cmd "terminal")
          (vim.cmd (.. "buffer " buffer-id)))
        (vim.cmd (.. "resize " height))
        (vim.cmd 
          "startinsert!
          set noshowmode
          set nonumber
          set norelativenumber")))))

(local lsp-installer (require :nvim-lsp-installer))
(local lsp-installer-servers (require :nvim-lsp-installer.servers))
(lsp-installer.on_server_ready 
  (fn [server]
    (server:setup  
      {
       :capabilities ((. (require :cmp_nvim_lsp) :update_capabilities)  
                      (vim.lsp.protocol.make_client_capabilities))
       :flags {:debounce_text_changes 150}
       :on_attach (fn [client buffer]
                    (vim.cmd "autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()"))

       }
      (vim.cmd "do User LspAttachBuffers"))))

(local servers [:pyright :tsserver :clangd :jdtls])

(each [_ server-name (ipairs servers)]
  (let [[ok server] [(lsp-installer-servers.get_server server-name)]]
    (if (and ok (not (server:is_installed)))
      (server:install))))

(local signs { :Error "!" :Warning  "*" :Hint "$" :Info "#" })
(each [type icon (pairs signs)]
  (local hl (.. :LspDiagnosticsSign  type))
  (vim.fn.sign_define hl { :text icon :texthl hl :numhl hl }))

(vim.fn.sign_define :LightBulbSign { :text "@" :texthl "DiagnosticWarn" :linehl "" :numhl "" })

(local cmp (require :cmp))
(local lspkind (require :lspkind))

(cmp.setup 
  {
   :snippet { :expand (fn [args] (vim.fn.vsnip#anonymous args.body)) }
   :mapping 
   {
    "<C-Space>" (cmp.mapping ((cmp.mapping.complete) [ "i" "c" ]))
    "<C-y>"     cmp.config.disable
    "<C-e>"     (cmp.mapping {
                              :i (cmp.mapping.abort)
                              :c (cmp.mapping.close)
                              })
    "<CR>" (cmp.mapping.confirm { :select false })
    }
   :sources  (cmp.config.sources 
               [ 
                {:name "nvim_lsp" }
                {:name "path" }
                {:name "vsnip" }
                {:name "conjure"}
                {:name "buffer" }
                ])
   :formatting 
   {
    :format (lspkind.cmp_format 
              {
               :with_text false
               :maxwidth 50
               :symbol_map  
               {
                :Text          "tx"
                :Method        "m"
                :Function      "f"
                :Constructor   "c"
                :Field         "f"
                :Variable      "v"
                :Class         "c"
                :Interface     "i"
                :Module        "{"
                :Property      "p"
                :Unit          "u"
                :Value         "v"
                :Enum          "en"
                :Keyword       "kw"
                :Snippet       "sn"
                :Color         "cl"
                :File          "fl"
                :Reference     "rf"
                :Folder        "dr"
                :EnumMember    "e"
                :Constant      "c"
                :Struct        "st"
                :Event         "ec"
                :Operator      "op"
                :TypeParameter "t"
                }})}})

((. (require :nvim_comment) :setup))
((. (require :nvim-autopairs) :setup) 
 { :disable_filetype [ :fennel :clojure ] })
