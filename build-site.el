;; Set the package installation directory so that packages aren't stored in the
;; ~/.emacs.d/elpa path.
(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))


;; Install dependencies
(package-install 'htmlize)
(package-install 'citeproc)

(require 'org)
(require 'oc-csl)
(require 'oc-biblatex)


(require 'ox-publish)

;; Customize the HTML output
(setq org-html-validation-link nil            ;; Don't show validation link
      org-html-head-include-scripts nil       ;; Use our own scripts
      org-html-head-include-default-style nil ;; Use our own styles
      org-html-head "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />")

;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "org-site:main"
             :recursive t
             :base-directory "./content"
             :publishing-function 'org-html-publish-to-html
             :publishing-directory "./public"
             :with-author nil           ;; Don't include author name
             :with-creator t            ;; Include Emacs and Org versions in footer
             :with-toc nil              ;; Include a table of contents
             :section-numbers nil       ;; Don't include section numbers
             :time-stamp-file nil       ;; Don't include time stamp in file
             :htmlized-source t
             :html-preamble "<style>
                              #navbar ul {
                                list-style-type: none;
                                margin: 0;
                                padding: 0;
                                overflow: hidden;
                              }


                              #navbar li {
                                float: left;
                              }

                              #navbar li a {
                                display: block;
                                text-align: center;
                                padding: 14px 16px;
                                text-decoration: none;
                              }

                              #navbar li a:hover {
                              }

                              #navbar li a.current {
                                  /* Styles for active link */
                                  background-color: #000;
                                  color: #fff;
                                }
                            </style>
                            "

         :html-postamble nil)))



;; Generate the site output
(org-publish-all t)


(message "Build complete!")
