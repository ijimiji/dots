static int topbar                        = 1;                      /* -b  option; if 0, dmenu appears at bottom     */
static int fuzzy                         = 1;                      /* -F  option; if 0, dmenu doesn't use fuzzy matching     */
static int centered                      = 1;                    /* -c option; centers dmenu on screen */
static int min_width                     = 500;                    /* minimum width when centered */
static const char *prompt                = NULL;      /* -p  option; prompt to the left of input field */
static unsigned int lines                = 6;
static const unsigned int border_width   = 0;
static const char *fonts[]               = {
	"Iosevka:size= 20"
};
static const char *colors[SchemeLast][2] = {
	/*     fg         bg       */
	[SchemeNorm]          = { "#d8dee9", "#2e3440" },
	[SchemeSel]           = { "#ebcb8b", "#2e3440" },
	[SchemeSelHighlight]  = { "#ebcb8b", "#2e3440" },
	[SchemeNormHighlight] = { "#ebcb8b", "#2e3440" },
	[SchemeOut]           = { "#859900", "#00ffff" },
};

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";
