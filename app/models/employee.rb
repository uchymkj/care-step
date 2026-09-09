class Employee < ApplicationRecord
  belongs_to :department
  has_many :employee_procedures
end
