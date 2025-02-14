import 'package:building_ui/exports/exports.dart';
import 'package:building_ui/screens/home/products_tabs/shoe_tabs.dart';

import '../../services/local_notification.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  late final LocalNotificationService service;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    service = LocalNotificationService();
    service.initialize();
    listenToNotification();
    service.showScheduledNotification();

    ref.read(myHomeScreenModel.notifier).getUsername();
    ref.read(myHomeScreenModel.notifier).getShoeProducts();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(myHomeScreenModel);
    return Scaffold(
      body:
      // : state.loadingState == LoadingState.loading
      //     ? const Center(child: CircularProgressIndicator())
      //     : state.loadingState == LoadingState.error
      //         ? const Center(child: Text('Oops! Something went wrong'))
      //         :
              
               Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SafeArea(
                    bottom: false,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.0.h),
                      child: Column(
                        children: [
                          SizedBox(height: 19.0.h),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/images/person.png'),
                                  radius: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 90.0),
                                  child: Text(
                                    'Good day,${state.userModel.username}',
                                    style: AppStyles.normalgreyText,
                                  ),
                                ),
                                const Icon(
                                  Icons.shopping_cart_checkout_outlined,
                                  size: 30,
                                  color: AppColors.lightgreyColor,
                                ),
                              ]),

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
                              padding:
                                  EdgeInsets.only(top: 8.0.h, left: 10.0.w),
                              child: Text('New items with \nfree shipping',
                                  style: AppStyles.boldgreyText),
                            ),
                          ),
                          SizedBox(
                            height: 19.0.h,
                          ),
                          // give the tab bar a height [can change hheight to preferred height]
                          TabBar(
                            controller: _tabController,
                            indicatorColor: AppColors.purpleColor,
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.black,
                            tabs: const [
                              // first tab [you can add an icon using the icon property]
                              Tab(
                                child: Categories(
                                  image: 'assets/icons/shoe.png',
                                  title: 'Shoes',
                                ),
                              ),

                              Tab(
                                child: Categories(
                                  image: 'assets/icons/hoodie.png',
                                  title: 'Hoodies',
                                ),
                              ),
                              Tab(
                                child: Categories(
                                  image: 'assets/icons/tshirt.png',
                                  title: 'T-shirt',
                                ),
                              ),
                              Tab(
                                child: Categories(
                                  image: 'assets/icons/watch.png',
                                  title: 'Watches',
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 19.0.h,
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: _tabController,
                              children: const [
                               ShoesTab(),
                              
                                Center(
                                  child: Text(
                                    'Hoodies Coming Soon',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'T-Shirts Coming SOon',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Wrist Watches Coming SOon',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }

//* Activating Local Notifications
  void listenToNotification() {
    service.onNotificationClick.stream.listen(onNotificationListener);
  }

  void onNotificationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: ((context) => const HomeScreen())));
    }
  }
}
