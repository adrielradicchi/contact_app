defmodule ContactApp.ContactsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ContactApp.Contacts` context.
  """

  @doc """
  Generate a contact.
  """
  def contact_fixture(attrs \\ %{}) do
    {:ok, contact} =
      attrs
      |> Enum.into(%{
        email: "some email",
        name: "some name",
        phone: "some phone"
      })
      |> ContactApp.Contacts.create_contact()

    contact
  end
end
