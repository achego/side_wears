import 'package:building_ui/exports/exports.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final FirestoreCollectionService _firestoreCollectionService =
      FirestoreCollectionService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: RefreshIndicator(
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          onRefresh: () async {
            setState(() {});
          },
          child: SafeArea(
            bottom: false,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15.0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 19.0.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/person.png'),
                        radius: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 90.0),
                        child: FutureBuilder<DocumentSnapshot>(
                            future: _firestoreCollectionService.usersRef
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .get(),
                            builder: (BuildContext context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child:
                                        CircularProgressIndicator.adaptive());
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.none) {
                                return const Center(child: Text('No data'));
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                Map<String, dynamic> data = snapshot.data!
                                    .data() as Map<String, dynamic>;

                                return Padding(
                                  padding: const EdgeInsets.only(right: 48.0),
                                  child: Text(
                                    'Good Day, ${data['username']}',
                                    style: AppStyles.normalgreyText,
                                  ),
                                );
                              }
                              return const Center(child: Text('No data'));
                            }),
                      ),
                      const Icon(
                        Icons.shopping_cart_checkout_outlined,
                        size: 30,
                        color: AppColors.lightgreyColor,
                      ),
                    ],
                  ),
                  SizedBox(height: 22.0.h),
                  Container(
                    height: 150.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0.r),
                      ),
                      image: const DecorationImage(
                          image: AssetImage('assets/images/st.jpg'),
                          fit: BoxFit.cover),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.0.h, left: 10.0.w),
                      child: Text('New items with \nfree shipping',
                          style: AppStyles.boldwhiteText),
                    ),
                  ),
                  const SizedBox(
                    height: 19,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Popular Categories',
                          style: AppStyles.normalgreyText),
                      const Text(
                        'See all',
                        style: TextStyle(
                            color: AppColors.lightgreyColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  SizedBox(height: 10.0.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Categories(
                        image: 'assets/icons/tshirt.png',
                        title: 'T-Shirt',
                      ),
                      Categories(
                        image: 'assets/icons/shoe.png',
                        title: 'Shoes',
                      ),
                      Categories(
                        image: 'assets/icons/hoodie.png',
                        title: 'Hoodies',
                      ),
                      Categories(
                        image: 'assets/icons/watch.png',
                        title: 'Watches',
                      ),
                    ],
                  ),
                  SizedBox(height: 15.0.h),
                  Text('Sneakers for you', style: AppStyles.normalgreyText),
                  SizedBox(height: 15.0.h),
                  FutureBuilder<QuerySnapshot>(
                    future: _firestoreCollectionService.productsRef.get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator.adaptive());
                      }
                      if (snapshot.connectionState == ConnectionState.none) {
                        return const Center(child: Text('No data'));
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        return SizedBox(
                          height: 250.0.h,
                          child: ScrollConfiguration(
                            behavior: RemoveScrollGlow(),
                            child: GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 3,
                              controller:
                                  ScrollController(keepScrollOffset: false),
                              mainAxisSpacing: 3,
                              semanticChildCount: 6,
                              children: snapshot.data!.docs.map(
                                (document) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProductDetails(
                                            productId: document.id,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Sneakers(
                                      prodImage: (document.data()
                                          as dynamic)['product_image'][0],
                                      prodName:
                                          '${(document.data() as dynamic)['product_name']}',
                                      prodPrice:
                                          '\$${(document.data() as dynamic)['product_price']}',
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        );
                      }
                      return const Center(child: Text('No data'));
                    },
                  ),
                  SizedBox(height: 10.0.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Categories(
                        image: 'assets/icons/tshirt.png',
                        title: 'T-Shirt',
                      ),
                      Categories(
                        image: 'assets/icons/shoe.png',
                        title: 'Shoes',
                      ),
                      Categories(
                        image: 'assets/icons/hoodie.png',
                        title: 'Hoodies',
                      ),
                      Categories(
                        image: 'assets/icons/watch.png',
                        title: 'Watches',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
