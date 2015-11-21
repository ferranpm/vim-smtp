function! smtp#new()
    call inputsave()

    " Get recipients
    let mail_to = []
    let inp = input("To: ")
    while inp != ""
        call add(mail_to, inp)
        let inp = input("To: ")
    endwhile

    let mail_subject = input("Subject: ")

    call inputrestore()

    execute 'new '.tempname()
    setlocal filetype=mail
    let lines = [
                \ 'From: <'.g:email_address.'>',
                \ 'To: <'.join(mail_to, '>, <').'>',
                \ 'Subject: '.mail_subject,
                \ 'Content-Type: multipart/mixed; boundary=vim-smpt-plugin-boundary',
                \ '',
                \ '--vim-smpt-plugin-boundary',
                \ ''
                \ ]
    call setline(1, lines)
    normal! G
endfunction

function! smtp#attach(filename)
    let expanded = expand(a:filename)
    let lines = [
                \ '--vim-smpt-plugin-boundary',
                \ 'Content-Type: application/vnd.openxmlformats-officedocument.wordprocessingml.document; name=""',
                \ ''
                \ ]
    call extend(lines, readfile(expanded))
    call setline(line('$'), lines)
endfunction

function! smtp#send()
    update
    call system('cat '.expand('%').' | msmtp --read-recipients')
endfunction
