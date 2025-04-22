# db/seeds.rb

# Clear existing data
puts "Clearing existing data..."
Review.destroy_all
Payment.destroy_all
Booking.destroy_all
Package.destroy_all
PhotographerProfile.destroy_all
User.destroy_all

# Create admin user
admin = User.create!(
  email: 'admin@weddingphotography.com',
  password: 'password123',
  password_confirmation: 'password123',
  first_name: 'Admin',
  last_name: 'User',
  role: :admin
)

# Create client users
5.times do |i|
  User.create!(
    email: "client#{i+1}@example.com",
    password: 'password123',
    password_confirmation: 'password123',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    phone: Faker::PhoneNumber.cell_phone,
    role: :client
  )
end

# Create photographer users with profiles
10.times do |i|
  user = User.create!(
    email: "photographer#{i+1}@example.com",
    password: 'password123',
    password_confirmation: 'password123',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    phone: Faker::PhoneNumber.cell_phone,
    role: :photographer
  )
  
  profile = PhotographerProfile.create!(
    user: user,
    business_name: "#{user.first_name}'s Wedding Photography",
    description: Faker::Lorem.paragraph(sentence_count: 5),
    experience_years: rand(1..15),
    hourly_rate: rand(100..500),
    location: Faker::Address.city,
    available: true
  )
  
  # Create packages for each photographer
  3.times do |j|
    Package.create!(
      photographer_profile: profile,
      name: ["Basic Package", "Premium Package", "Luxury Package"][j],
      description: Faker::Lorem.paragraph(sentence_count: 3),
      price: [1000, 2500, 5000][j],
      duration_hours: [4, 8, 12][j],
      included_services: [
        ["4 hours coverage", "1 photographer", "Online gallery"],
        ["8 hours coverage", "2 photographers", "Online gallery", "Engagement session"],
        ["12 hours coverage", "2 photographers", "Online gallery", "Engagement session", "Wedding album", "Second shooter"]
      ][j],
      active: true
    )
  end
end

# Create some bookings
clients = User.where(role: :client)
photographers = PhotographerProfile.all

10.times do
  client = clients.sample
  photographer = photographers.sample
  package = photographer.packages.sample
  
  booking = Booking.create!(
    client: client,
    photographer_profile: photographer,
    package: package,
    event_date: rand(1..12).months.from_now,
    event_location: Faker::Address.full_address,
    special_requests: Faker::Lorem.paragraph,
    status: [:pending, :confirmed, :completed].sample
  )
  
  # Create payment for confirmed or completed bookings
  if booking.confirmed? || booking.completed?
    Payment.create!(
      booking: booking,
      amount: booking.total_amount,
      platform_fee: booking.platform_fee,
      photographer_payout: booking.photographer_payout,
      status: :completed,
      stripe_payment_id: "ch_#{SecureRandom.hex(12)}"
    )
  end
  
  # Create review for completed bookings
  if booking.completed?
    Review.create!(
      booking: booking,
      client: booking.client,
      photographer_profile: booking.photographer_profile,
      rating: rand(3..5),
      content: Faker::Lorem.paragraph(sentence_count: 3)
    )
  end
end

puts "Seed data created successfully!"
puts "Admin user: admin@weddingphotography.com (password: password123)"
puts "Created #{User.count} users"
puts "Created #{PhotographerProfile.count} photographer profiles"
puts "Created #{Package.count} packages"
puts "Created #{Booking.count} bookings"
puts "Created #{Payment.count} payments"
puts "Created #{Review.count} reviews"