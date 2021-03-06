require_relative "boot"
require "active_support/all"

report = PagSeguro::Transaction.find_by_date(starts_at: 29.days.ago, per_page: 1)

while report.next_page?
  report.next_page!
  puts "== Page #{report.page}"
  abort "=> Errors: #{report.errors.join("\n")}" unless report.valid?
  puts "Report created on #{report.created_at}"
  puts

  report.transactions.each do |transaction|
    puts "=> Transaction"
    puts "   created_at: #{transaction.created_at}"
    puts "   code: #{transaction.code}"
    puts "   cancellation_source: #{transaction.cancellation_source}"
    puts "   payment method: #{transaction.payment_method.type}"
    puts "   gross amount: #{transaction.gross_amount}"
    puts "   updated at: #{transaction.updated_at}"
    puts
  end
end
