# Wedding Photography Platform

A Rails 8.0.2 application that connects wedding clients with professional photographers. The platform handles bookings, payments, and manages a 20% commission on each transaction.

## Features

### For Clients
- Browse photographer profiles and portfolios
- View wedding packages and pricing
- Book photographers for events
- Make secure payments
- Leave reviews after events

### For Photographers
- Create and manage professional profiles
- Set up customizable wedding packages
- Accept or decline booking requests
- Track earnings and payouts
- View client reviews

### Platform Features
- Automated 20% commission calculation
- Payment processing with Stripe integration
- Email notifications for all transactions
- Secure authentication system
- Review and rating system

## Technical Stack
- Ruby on Rails 8.0.2
- PostgreSQL database
- Stripe for payment processing
- ActiveStorage for image uploads
- TailwindCSS for styling
- RSpec for testing

## Setup Instructions

1. **Clone the repository**
```bash
git clone <repository-url>
cd wedding_photography_platform
```

2. **Install dependencies**
```bash
bundle install
yarn install
```

3. **Database setup**
```bash
rails db:create
rails db:migrate
rails db:seed # Optional: adds sample data
```

4. **Environment variables**
Create a `.env` file with:
```
STRIPE_PUBLISHABLE_KEY=your_stripe_publishable_key
STRIPE_SECRET_KEY=your_stripe_secret_key
```

5. **Start the server**
```bash
rails server
```

Visit `http://localhost:3000` to access the application.

## Key Models

### User
- Has roles: client, photographer, admin
- Authentication with BCrypt
- Can have a photographer profile

### PhotographerProfile
- Belongs to a User
- Has multiple packages and bookings
- Contains portfolio images

### Package
- Belongs to a PhotographerProfile
- Has name, description, price, duration
- Can be included in bookings

### Booking
- Connects clients with photographers
- Has status workflow (pending, confirmed, completed, cancelled)
- Associated with a payment

### Payment
- Handles financial transactions
- Calculates platform fees (20%)
- Integrates with Stripe

## Testing

Run the test suite:
```bash
rspec
```

## Deployment Considerations

1. **Database**: Set up a production PostgreSQL database
2. **Storage**: Configure ActiveStorage for cloud storage (AWS S3, etc.)
3. **Environment**: Set production environment variables
4. **Assets**: Precompile assets with `rails assets:precompile`
5. **SSL**: Ensure HTTPS is configured

## Commission Structure

- Platform keeps 20% of each booking
- Photographers receive 80% of their package price
- Payments are processed through Stripe
- Payouts are handled automatically

## Future Enhancements

1. **Calendar Integration**: Sync with Google Calendar/iCal
2. **Advanced Search**: Filter by location, price, availability
3. **Chat System**: Direct messaging between clients and photographers
4. **Analytics Dashboard**: Track bookings, revenue
5. **Mobile App**: Native iOS/Android applications
6. **Video Consultations**: Built-in video chat for client meetings
7. **Contract Management**: Digital contract signing

## Payment Flow

1. Client selects a package and creates a booking
2. System calculates total amount (package price)
3. Client makes payment through Stripe
4. Platform automatically deducts 20% commission
5. Photographer receives 80% payout after event completion

## Security Features

- Secure password hashing with BCrypt
- CSRF protection
- Strong parameter filtering
- Role-based access control
- Secure payment processing with Stripe
- SSL/TLS encryption for production

## API Integration

The application is designed to work with:
- Stripe for payment processing
- AWS S3 for image storage (production)
- SendGrid/Mailgun for email delivery (production)

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support, email support@weddingphotography.com or open an issue in the repository.