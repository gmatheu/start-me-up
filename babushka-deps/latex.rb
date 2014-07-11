LATEX_PACKAGES=%Q|
texlive-latex-base
texlive-latex-extra
texlive-fonts-recommended
texlive-latex-recommended
|.split

dep 'latex' do
  requires 'texmaker.bin'
  requires LATEX_PACKAGES.map {|p| "#{p}.lib" }
end

LATEX_PACKAGES.each { |p| dep "#{p}.lib" }
dep 'texmaker.bin'

def deps_for names, suffix
  names.each do |n|
    dep "#{n}.#{suffix}"
  end
end

