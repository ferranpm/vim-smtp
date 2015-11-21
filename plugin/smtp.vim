if !exists('g:email_address')
    let g:email_address = $USER.'@'.$HOST
endif

command! -nargs=0 SMTPNew call smtp#new()
command! -nargs=0 SMTPSend call smtp#send()
command! -nargs=1 -complete=file SMTPAttach call smtp#attach(<q-args>)
