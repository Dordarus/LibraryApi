require 'rails_helper'

RSpec.describe Author, type: :model do
  it { should have_many(:books).dependent(:destroy) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:bio) }
end
