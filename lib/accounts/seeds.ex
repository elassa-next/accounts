defmodule Accounts.Seeds do
  alias Accounts.Constants
  alias Accounts.Context.Users
  alias Accounts.Context.Permissions.Permissions
  alias Accounts.Context.Permissions.Roles
  alias Accounts.Context.Profiles.Admins
  alias Accounts.Context.Profiles.Teachers
  alias Accounts.Context.Profiles.Students
  alias Accounts.Context.Residence.Countries
  alias Accounts.Context.Residence.States
  alias Accounts.Context.Residence.Cities
  alias Accounts.Context.Residence.Addresses

  def run do
    {:ok, country} = Countries.create_country(%{"name" => "syria"})
    {:ok, state} = States.create_state(%{"country_id" => country.id, "name" => "afrin"})
    {:ok, city} = Cities.create_city(%{"state_id" => state.id, "name" => "afrin"})

    {:ok, address} =
      Addresses.create_address(%{"city_id" => city.id, "neighborhood" => "al mazoot street"})

    {:ok, accounts_residence_index} =
      Permissions.create_permission(%{"name" => "accounts_residence_index"})

    {:ok, accounts_residence_create} =
      Permissions.create_permission(%{"name" => "accounts_residence_create"})

    {:ok, accounts_residence_show} =
      Permissions.create_permission(%{"name" => "accounts_residence_show"})

    {:ok, accounts_residence_update} =
      Permissions.create_permission(%{"name" => "accounts_residence_update"})

    {:ok, accounts_residence_delete} =
      Permissions.create_permission(%{"name" => "accounts_residence_delete"})

    {:ok, accounts_permission_index} =
      Permissions.create_permission(%{"name" => "accounts_permission_index"})

    {:ok, accounts_role_index} = Permissions.create_permission(%{"name" => "accounts_role_index"})

    {:ok, accounts_role_create} =
      Permissions.create_permission(%{"name" => "accounts_role_create"})

    {:ok, accounts_role_show} = Permissions.create_permission(%{"name" => "accounts_role_show"})

    {:ok, accounts_role_update} =
      Permissions.create_permission(%{"name" => "accounts_role_update"})

    {:ok, accounts_role_delete} =
      Permissions.create_permission(%{"name" => "accounts_role_delete"})

    {:ok, accounts_role_assign} =
      Permissions.create_permission(%{"name" => "accounts_role_assign"})

    {:ok, accounts_user_index} = Permissions.create_permission(%{"name" => "accounts_user_index"})

    {:ok, accounts_user_create} =
      Permissions.create_permission(%{"name" => "accounts_user_create"})

    {:ok, accounts_user_show} = Permissions.create_permission(%{"name" => "accounts_user_show"})

    {:ok, accounts_user_update} =
      Permissions.create_permission(%{"name" => "accounts_user_update"})

    {:ok, accounts_user_delete} =
      Permissions.create_permission(%{"name" => "accounts_user_delete"})

    {:ok, accounts_user_assign} =
      Permissions.create_permission(%{"name" => "accounts_user_assign"})

    {:ok, profile_admin_index} = Permissions.create_permission(%{"name" => "profile_admin_index"})

    {:ok, profile_admin_create} =
      Permissions.create_permission(%{"name" => "profile_admin_create"})

    {:ok, profile_admin_show} = Permissions.create_permission(%{"name" => "profile_admin_show"})

    {:ok, profile_admin_update} =
      Permissions.create_permission(%{"name" => "profile_admin_update"})

    {:ok, profile_admin_delete} =
      Permissions.create_permission(%{"name" => "profile_admin_delete"})

    {:ok, profile_teacher_index} =
      Permissions.create_permission(%{"name" => "profile_teacher_index"})

    {:ok, profile_teacher_create} =
      Permissions.create_permission(%{"name" => "profile_teacher_create"})

    {:ok, profile_teacher_show} =
      Permissions.create_permission(%{"name" => "profile_teacher_show"})

    {:ok, profile_teacher_update} =
      Permissions.create_permission(%{"name" => "profile_teacher_update"})

    {:ok, profile_teacher_delete} =
      Permissions.create_permission(%{"name" => "profile_teacher_delete"})

    {:ok, profile_student_index} =
      Permissions.create_permission(%{"name" => "profile_student_index"})

    {:ok, profile_student_create} =
      Permissions.create_permission(%{"name" => "profile_student_create"})

    {:ok, profile_student_show} =
      Permissions.create_permission(%{"name" => "profile_student_show"})

    {:ok, profile_student_update} =
      Permissions.create_permission(%{"name" => "profile_student_update"})

    {:ok, profile_student_delete} =
      Permissions.create_permission(%{"name" => "profile_student_delete"})

    {:ok, admin_role} =
      Roles.create_role(%{
        "name" => "admin",
        "scope" => Constants.admin()
      })

    {:ok, _teacher_role} =
      Roles.create_role(%{
        "name" => "teacher",
        "scope" => Constants.teacher()
      })

    {:ok, _student_role} =
      Roles.create_role(%{
        "name" => "student",
        "scope" => Constants.student()
      })

    Roles.assign_permissions(admin_role, [
      accounts_residence_index.id,
      accounts_residence_create.id,
      accounts_residence_show.id,
      accounts_residence_update.id,
      accounts_residence_delete.id,
      ######
      accounts_permission_index.id,
      ######
      accounts_role_index.id,
      accounts_role_create.id,
      accounts_role_show.id,
      accounts_role_update.id,
      accounts_role_delete.id,
      accounts_role_assign.id,
      ######
      accounts_user_index.id,
      accounts_user_create.id,
      accounts_user_show.id,
      accounts_user_update.id,
      accounts_user_delete.id,
      accounts_user_assign.id,
      ######
      profile_admin_index.id,
      profile_admin_create.id,
      profile_admin_show.id,
      profile_admin_update.id,
      profile_admin_delete.id,
      ######
      profile_teacher_index.id,
      profile_teacher_create.id,
      profile_teacher_show.id,
      profile_teacher_update.id,
      profile_teacher_delete.id,
      ######
      profile_student_index.id,
      profile_student_create.id,
      profile_student_show.id,
      profile_student_update.id,
      profile_student_delete.id
    ])

    {:ok, admin_user} =
      Users.create_user(%{
        "username" => "admin",
        "password" => "12345678"
      })

    {:ok, teacher_user} =
      Users.create_user(%{
        "username" => "teacher",
        "password" => "12345678"
      })

    {:ok, student_user} =
      Users.create_user(%{
        "username" => "student",
        "password" => "12345678"
      })

    # Accounts.change_super_admin(admin.user.id, true)

    {:ok, _admin_profile} =
      Admins.create_admin(%{
        "first_name" => "Admin first",
        "last_name" => "Admin last",
        "dob" => "1994-01-06",
        "address_id" => address.id,
        "user_id" => admin_user.id
      })

    {:ok, _teacher_profile} =
      Teachers.create_teacher(%{
        "first_name" => "Teacher first",
        "last_name" => "Teacher last",
        "dob" => "1994-01-06",
        "address_id" => address.id,
        "user_id" => teacher_user.id
      })

    {:ok, _student_profile} =
      Students.create_student(%{
        "first_name" => "Student first",
        "last_name" => "Student last",
        "dob" => "1994-01-06",
        "address_id" => address.id,
        "user_id" => student_user.id
      })

    Users.assign_roles(admin_user, Constants.admin(), [admin_role.id])
  end
end
