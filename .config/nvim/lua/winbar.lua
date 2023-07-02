local icons = require('utils.icons')

local winbar_ignore_filetypes = {
  NvimTree = true,
  floaterm = true,
}

function winbar()
  local w = ''

  local parent_directory = string.match(vim.fn.expand('%:h'), "/(%w+)$") or '[No Directory]'
  local current_file = vim.fn.expand('%:t')
  local current_file_extension = vim.fn.fnamemodify(current_file, ':e')

  if current_file == '' then
    current_file = '[No Name]'
  end

  local icon = icons.get_icon(current_file, current_file_extension)

  w = w .. '%#Directory#' .. parent_directory
  w = w .. '  ' .. icon .. '%#Directory# ' .. current_file

  local is_location_available = require('nvim-navic').is_available()

  if is_location_available then
    local location = require('nvim-navic').get_location()

    if location ~= '' then
      w = w .. '  ' .. location
    end
  end

  return w
end

vim.api.nvim_create_autocmd('BufWinEnter', {
  pattern = '*',
  callback = function()
    if winbar_ignore_filetypes[vim.bo.filetype] then
      return
    end

    vim.wo.winbar = '%{%v:lua.winbar()%}'
  end
})
