module ContactsHelper
  def contacts_for_user_id(user_id)
    Contact.joins(<<-SQL, user_id)
    LEFT JOIN contact_shares cs ON cs.contact_id = contacts.id
    WHERE contacts.user_id = ? OR cs.user_id = ?
    SQL
  end
end
