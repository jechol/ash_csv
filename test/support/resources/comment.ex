# SPDX-FileCopyrightText: 2020 ash_csv contributors <https://github.com/ash-project/ash_csv/graphs/contributors>
#
# SPDX-License-Identifier: MIT

defmodule AshCsv.Test.Comment do
  @moduledoc false
  use Ash.Resource,
    domain: AshCsv.Test.Domain,
    data_layer: AshCsv.DataLayer

  csv do
    create? true
    columns [:id, :title]
    file "test/data_files/comments.csv"
  end

  actions do
    default_accept([:title, :post_id])

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
  end

  relationships do
    belongs_to(:post, AshCsv.Test.Post, public?: true)
  end
end
