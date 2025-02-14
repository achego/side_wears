import 'package:building_ui/exports/exports.dart';



class PaymentView extends ConsumerStatefulWidget {
  const PaymentView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PaymentViewState();
}

class _PaymentViewState extends ConsumerState<PaymentView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: MyAppBar(
          isSettings: false,
          title: 'Select Payment',
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15.0.h),
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              const PaymentTile(
                type: 'Paypal',
                image: 'assets/icons/paypal.png',
              ),
              const PaymentTile(
                type: 'Credit card',
                image: 'assets/icons/master.png',
              ),
              const PaymentTile(
                type: 'Apple Pay',
                image: 'assets/icons/apple.png',
              ),
              const PaymentTile(
                type: 'Google Pay',
                image: 'assets/icons/google.png',
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5), //color of shadow
                      spreadRadius: 3, //spread radius
                      blurRadius: 9, // blur radius
                      offset: const Offset(0, 2),
                    ),
                    //you can set more BoxShadow() here
                  ],
                ),
                child: Column(
                  children: [
                    totalDetails('5', 'Selected'),
                    totalDetails('\$460', 'Subtotal'),
                    totalDetails('\$40', 'Delivery'),
                    totalDetails('\$480', 'Total'),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Center(
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CardPayment()));
                      },
                      child: const CustomButton(
                        buttonText: 'Next',
                        width: 300,
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
