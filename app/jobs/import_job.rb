class ImportJob < ApplicationJob
  queue_as :default

  def perform(simport:, suser:)
    CardImport.new(import: simport, user: suser).call
  end
end
