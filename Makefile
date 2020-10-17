all: clean

clean:
	find . -regex ".*~" | xargs rm -rf ;
	rm -rf ./emacs/.config/emacs/elpa ;
	rm ./emacs/.config/emacs/eshell/history ;
	rm ./emacs/.config/emacs/history ;
	rm -rf ./emacs/.config/emacs/auto-save-list ;
	rm ./emacs/.config/emacs/recentf ;
	rm ./emacs/.config/emacs/*.ttf
	rm -rf ./emacs/.config/emacs/.cache
	rm -rf ./emacs/.config/emacs/transient
	rm ./emacs/.config/emacs/.dap-breakpoints
	rm ./emacs/.config/emacs/.lsp-session-v1


install:
	echo hello

push_git:
	echo hello
