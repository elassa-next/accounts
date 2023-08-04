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

    {:ok, residence_index} =
      Permissions.create_permission(%{"name" => "residence_index"})

    {:ok, residence_create} =
      Permissions.create_permission(%{"name" => "residence_create"})

    {:ok, residence_show} =
      Permissions.create_permission(%{"name" => "residence_show"})

    {:ok, residence_update} =
      Permissions.create_permission(%{"name" => "residence_update"})

    {:ok, residence_delete} =
      Permissions.create_permission(%{"name" => "residence_delete"})

    {:ok, permissions_permission_index} =
      Permissions.create_permission(%{"name" => "permissions_permission_index"})

    {:ok, permissions_role_index} = Permissions.create_permission(%{"name" => "permissions_role_index"})

    {:ok, permissions_role_create} =
      Permissions.create_permission(%{"name" => "permissions_role_create"})

    {:ok, permissions_role_show} = Permissions.create_permission(%{"name" => "permissions_role_show"})

    {:ok, permissions_role_update} =
      Permissions.create_permission(%{"name" => "permissions_role_update"})

    {:ok, permissions_role_delete} =
      Permissions.create_permission(%{"name" => "permissions_role_delete"})

    {:ok, permissions_role_assign} =
      Permissions.create_permission(%{"name" => "permissions_role_assign"})

    {:ok, users_index} = Permissions.create_permission(%{"name" => "users_index"})

    {:ok, users_create} =
      Permissions.create_permission(%{"name" => "users_create"})

    {:ok, users_show} = Permissions.create_permission(%{"name" => "users_show"})

    {:ok, users_update} =
      Permissions.create_permission(%{"name" => "users_update"})

    {:ok, users_delete} =
      Permissions.create_permission(%{"name" => "users_delete"})

    {:ok, users_assign} =
      Permissions.create_permission(%{"name" => "users_assign"})

    {:ok, profiles_admin_index} = Permissions.create_permission(%{"name" => "profiles_admin_index"})

    {:ok, profiles_admin_create} =
      Permissions.create_permission(%{"name" => "profiles_admin_create"})

    {:ok, profiles_admin_show} = Permissions.create_permission(%{"name" => "profiles_admin_show"})

    {:ok, profiles_admin_update} =
      Permissions.create_permission(%{"name" => "profiles_admin_update"})

    {:ok, profiles_admin_delete} =
      Permissions.create_permission(%{"name" => "profiles_admin_delete"})

    {:ok, profiles_teacher_index} =
      Permissions.create_permission(%{"name" => "profiles_teacher_index"})

    {:ok, profiles_teacher_create} =
      Permissions.create_permission(%{"name" => "profiles_teacher_create"})

    {:ok, profiles_teacher_show} =
      Permissions.create_permission(%{"name" => "profiles_teacher_show"})

    {:ok, profiles_teacher_update} =
      Permissions.create_permission(%{"name" => "profiles_teacher_update"})

    {:ok, profiles_teacher_delete} =
      Permissions.create_permission(%{"name" => "profiles_teacher_delete"})

    {:ok, profiles_student_index} =
      Permissions.create_permission(%{"name" => "profiles_student_index"})

    {:ok, profiles_student_create} =
      Permissions.create_permission(%{"name" => "profiles_student_create"})

    {:ok, profiles_student_show} =
      Permissions.create_permission(%{"name" => "profiles_student_show"})

    {:ok, profiles_student_update} =
      Permissions.create_permission(%{"name" => "profiles_student_update"})

    {:ok, profiles_student_delete} =
      Permissions.create_permission(%{"name" => "profiles_student_delete"})

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
      residence_index.id,
      residence_create.id,
      residence_show.id,
      residence_update.id,
      residence_delete.id,
      ######
      permissions_permission_index.id,
      ######
      permissions_role_index.id,
      permissions_role_create.id,
      permissions_role_show.id,
      permissions_role_update.id,
      permissions_role_delete.id,
      permissions_role_assign.id,
      ######
      users_index.id,
      users_create.id,
      users_show.id,
      users_update.id,
      users_delete.id,
      users_assign.id,
      ######
      profiles_admin_index.id,
      profiles_admin_create.id,
      profiles_admin_show.id,
      profiles_admin_update.id,
      profiles_admin_delete.id,
      ######
      profiles_teacher_index.id,
      profiles_teacher_create.id,
      profiles_teacher_show.id,
      profiles_teacher_update.id,
      profiles_teacher_delete.id,
      ######
      profiles_student_index.id,
      profiles_student_create.id,
      profiles_student_show.id,
      profiles_student_update.id,
      profiles_student_delete.id
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
