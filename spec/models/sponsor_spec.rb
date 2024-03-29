# frozen_string_literal: true

require 'spec_helper'

describe Sponsor do
  describe 'validations' do
    it 'is not valid without a name' do
      should validate_presence_of(:name)
    end

    it 'is not valid without a website url' do
      should validate_presence_of(:website_url)
    end
  end
end
