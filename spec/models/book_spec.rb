require 'rails_helper'

RSpec.describe Book, type: :model do
  it { should belong_to(:author) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:genre) }
  it { should validate_presence_of(:year) }
  it { should validate_presence_of(:plot) }
end
