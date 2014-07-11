LATEX_PACKAGES=%Q|
texlive-latex-base
texlive-latex-extra
texlive-fonts-recommended
texlive-latex-recommended
|.split

dep 'latex' do
  requires 'texmaker.bin'
  requires bin_dep(LATEX_PACKAGES)
end

dep 'texmaker.bin'
lib_for LATEX_PACKAGES

