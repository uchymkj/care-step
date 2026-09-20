require "test_helper"

class FactoryBotTest < ActiveSupport::TestCase
  test "FactoryBotで部署を作成できる" do
    department = create(:department)

    assert_equal "経理部", department.name
    assert department.persisted?
  end
end
