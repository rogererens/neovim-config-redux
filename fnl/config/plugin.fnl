(module config.plugin
  {autoload {nvim aniseed.nvim
             a aniseed.core
             util config.util
             packer packer}})

(defn- safe-require-plugin-config [name]
  (let [(ok? val-or-err) (pcall require (.. :config.plugin. name))]
    (when (not ok?)
      (print (.. "config error: " val-or-err)))))

(defn- use [...]
  "Iterates through the arguments as pairs and calls packer's use function for
  each of them. Works around Fennel not liking mixed associative and sequential
  tables as well."
  (let [pkgs [...]]
    (packer.startup
      (fn [use]
        (for [i 1 (a.count pkgs) 2]
          (let [name (. pkgs i)
                opts (. pkgs (+ i 1))]
            (-?> (. opts :mod) (safe-require-plugin-config))
            (use (a.assoc opts 1 name)))))))
  nil)

;;;; Neovim Plugins
;; :mod specifies namespace under plugin directory that contains modification options

(use
  ;;;; System

  ;; plugin Manager
  :wbthomason/packer.nvim {}
  ;; nvim config and plugins in Fennel
  :Olical/aniseed {:branch :develop}

  ;;;; Menu system & Neovim control
  :folke/which-key.nvim {:mod :which-key}

  ;;;; theme
  ;; Development related icons
  :kyazdani42/nvim-web-devicons {}

  ;; Pretty list for all your troubles
  :folke/trouble.nvim {:mod :trouble}
  ;; Add missing colours for themes
  :folke/lsp-colors.nvim {:mod :lspcolors}

  ;; Hightlight TODOs - :TodoQuickFix
  :folke/todo-comments.nvim
  {:requires [:nvim-lua/plenary.nvim]
   :mod :todocomments}

  ;; GitHub themes - dark and light variations configured in plugins/theme.fnl
  :projekt0n/github-nvim-theme {:mod :theme}

  ;; gruvbox theme - to set up plugin/theme.fnl before this works
  ;; :morhetz/gruvbox {:mod :theme-gruvbox}
  ;; Gruvbox contrast options to try: :soft :medium :hard
  ;; {:background :light :gruvbox-contrast-light :soft}
  ;; :morhetz/gruvbox {:mod :theme}

  ;; Light theme - may require plugin/theme.fnl or smilar to work
  ;; :ingram1107/vim-zhi {}

  ;;;; status line
  :nvim-lualine/lualine.nvim {:mod :lualine}


  ;;;; Navigation

  ;; peek at a line number
  :nacro90/numb.nvim {:mod :numb}

  ;; file searching
  :nvim-telescope/telescope.nvim
  {:requires [:nvim-telescope/telescope-ui-select.nvim
              :nvim-lua/popup.nvim
              :nvim-lua/plenary.nvim]
   :mod :telescope}

  ;;;; Version control
  ;; diff view
  :sindrets/diffview.nvim
  {:requires [:nvim-lua/plenary.nvim]
   :mod :diffview}


  ;; GitHub Issues and Pull Requests
  :pwntester/octo.nvim
  {:requires [:nvim-lua/plenary.nvim
              :nvim-telescope/telescope.nvim
              :kyazdani42/nvim-web-devicons]
   :mod :octo}

  ;; magit style
  :TimUntersberger/neogit
  {:requires [:nvim-lua/plenary.nvim
              :sindrets/diffview.nvim]
   :mod :neogit}


  ;; repl tools
  :Olical/conjure {:branch :master :mod :conjure}
  :clojure-vim/clojure.vim {}
  :clojure-vim/vim-jack-in {}

  ;; sexp and vim-style editing
  :guns/vim-sexp {:mod :sexp}

  :tpope/vim-abolish {}
  :tpope/vim-commentary {}

  ;; Database Client :DB
  :tpope/vim-dadbod {}
  :tpope/vim-dispatch {}
  :tpope/vim-fugitive {:mod :fugitive}
  :tpope/vim-repeat {}
  :tpope/vim-sexp-mappings-for-regular-people {}
  :tpope/vim-sleuth {}
  :tpope/vim-surround {}
  :tpope/vim-unimpaired {}


  ;; parsing system
  :nvim-treesitter/nvim-treesitter {:run ":TSUpdate"
                                    :mod :treesitter}

  ;; lsp
  :neovim/nvim-lspconfig {:mod :lspconfig}

  ; snippets
  :L3MON4D3/LuaSnip {:requires [:saadparwaiz1/cmp_luasnip]}

  ;; autocomplete
  :hrsh7th/nvim-cmp {:requires [:hrsh7th/cmp-buffer
                                :hrsh7th/cmp-nvim-lsp
                                :PaterJason/cmp-conjure]
                     :mod :cmp})