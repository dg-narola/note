class NoteMailer < ApplicationMailer
   default from: 'dg@narola.email'

   def share_email(sharenote,user)
     @sharenote = sharenote
     @user = user
     @url = 'http://localhost:3000/notes'
     mail(to: @sharenote.email, subject: 'Note Shared')
   end

   def reg_email(sharenote,user)
      @sharenote = sharenote
      @url  = 'http://localhost:3000/users/sign_up'
      @user = user
      mail(to: @sharenote.email, subject: 'Note Shared')
    end

    def edit_email(sendto,user,note)
       @note = note.title
       @noteid = note.id
       @sendto = sendto
       @user = user
       @url  = "http://localhost:3000/notes/#{@noteid}/sharenotes/updatepermission"
       mail(to: @sendto, subject: 'Edit Access Mail')
     end

end
