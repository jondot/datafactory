Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id
      String :name
      String :email
      DateTime :updated_at
      DateTime :created_at
    end
  end
end
