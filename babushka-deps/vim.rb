dep 'vim' do
  requires 'vim.bin', 'gvim.bin'
end

dep 'vim.bin' do
  provides 'vim >= 7.4'
end

dep 'gvim.bin' do
  installs 'vim-gnome'
  provides 'gvim >= 7.4'
end
