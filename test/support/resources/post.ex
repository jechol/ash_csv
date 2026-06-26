# SPDX-FileCopyrightText: 2020 ash_csv contributors <https://github.com/ash-project/ash_csv/graphs/contributors>
#
# SPDX-License-Identifier: MIT

defmodule AshCsv.Test.Post do
  @moduledoc false
  use Ash.Resource,
    domain: AshCsv.Test.Domain,
    data_layer: AshCsv.DataLayer

  csv do
    create? true
    columns [:id, :title, :score, :public, :unique]
    file "test/data_files/posts.csv"
  end

  actions do
    default_accept([:title, :score, :public, :unique])

    create :create do
      primary? true
    end

    read :read do
      primary? true
    end

    update :update do
      primary? true
    end

    destroy :destroy do
      primary? true
    end

    action :__input_warning_marker, :boolean do
      argument :__input_warning_marker, :boolean, public?: false

      run fn input, _context ->
        {:ok, input.arguments.__input_warning_marker}
      end
    end
  end

  attributes do
    uuid_primary_key(:id)
    attribute(:title, :string, public?: true)
    attribute(:score, :integer, public?: true)
    attribute(:public, :boolean, public?: true)
    attribute(:unique, :string, public?: true)
  end

  identities do
    identity(:unique_unique, [:unique])
  end

  relationships do
    has_many(:comments, AshCsv.Test.Comment, destination_attribute: :post_id, public?: true)
  end
end
