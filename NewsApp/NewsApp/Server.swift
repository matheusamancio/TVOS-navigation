/*
 * Copyright (c) 2015 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

final class Server {
  static let sharedInstance = Server()
  private init() {}

  func getNewsFeed() -> [News] {
    let news1 = News(dateString: "April 7, 2340", title: "Evil Aliens Detected", descriptionText: "A few flying saucers have been seen over Europe.")
    let news2 = News(dateString: "April 7, 2340", title: "Escapees Found", descriptionText: "Last Friday, a dozen inmates of a high security prison broke out and invaded the neighbouring town. After a week of pursuit, the police have managed to round up all the prisoners.")
    let news3 = News(dateString: "April 7, 2340", title: "Rare Flower Found at the top of Mt. Everest", descriptionText: "Among the frozen peaks of Mt. Everest, sits an unlikely resident. The Octaris flower, also known as the Cverasslis Dicotlarvus is among the rarest of flowers in the galaxy. Blooming only once per century, this is a phenomenal discovery for Paul Krudgerinko, a local.")
    let news4 = News(dateString: "April 7, 2340", title: "Zombies Incoming", descriptionText: "This can't be good. It's been 300 years since the first Zombie Apolcalypse that erupted due to a chemical munitions provider's secret experimental drug leaked out to a nearby creek. Reports of the historically renowned 'Pale Green Skin' syndrome has plagued an entire town. First responders are on the scene to assess the situation.")
    return [news1, news2, news3, news4]
  }

  func getMartianNews() -> [News] {
    let news1 = News(dateString: "April 7, 2340", title: "Mars-Earth Treaty Broken", descriptionText: "In the treaty of 2260, the Martians and Earthlings have signed a non-aggression pact that had become the symbol of peace and trust amongst the two races. Today, the 'Rouge Armada', the Martian's biggest orbital fleet has took flight, breaking one of the rules of the treaty.")
    let news2 = News(dateString: "April 6, 2340", title: "Tensions Rise Between the Two Races", descriptionText: "A week long argument over Lagrange 3 has concluded with both sides unable to reach a compromise. The United Earth Confederate and Martian Armada both claim ownership over the fabled Lagrange 3 point, where an abundance of Dark Matter presides in. Lagrange 3 has long been a scientifically rich subject, due to it being a special region in space where the net gravitational force exerted within the region is close to zero. In 23rd century, Physicist Alexandrov Bubulio postulated that Dark Matter was never seen by humans because of a special property that causes it to repel gravity.")
    let news3 = News(dateString: "April 5, 2340", title: "Martian Spy in the Venusian Consulate", descriptionText: "A Martian spy was discovered in the Venusian Consulate. When the person in charge was inquired about the matter, he responded: 'No idea how he got in.'")
    let news4 = News(dateString: "April 5, 2340", title: "Martians Riot", descriptionText: "The Martians, who detested the Olympus-Cordial agreement, has just entered a full scale riot. Many rioters are driving their UFOs to create havoc around their cities.")
    return [news1, news2, news3, news4]
  }

  func getEarthNews() -> [News] {
    let news1 = News(dateString: "April 7, 2340", title: "Goofball Fails Robbery Attempt", descriptionText:  "A man in his mid 30s tried to rob a local convenience store at Brentwood Mall. Unfortunately while he was pulling his weapon out, he realized he forgot to bring it; All the while announcing his robbery attempt at the cashier. The man got pinned down by nearby customers and police responded promptly")
    let news2 = News(dateString: "April 7, 2340" , title: "Gravy Festival", descriptionText: "Every year, in Canada, we have a gravy festival where many gravy providers ban together to provide a rich selection of gravies for all festival goers to sample.")
    let news3 = News(dateString: "April 7, 2340", title: "April Fools Debacle Exposed", descriptionText: "A viral youtube video of last week's April Fool's debacle concluded with a candid video showing the prepetrators planning the whole scenario and taking a video of their skit. What was a popular viral video quickly deteroriated to a public backlash.")
    return [news1, news2, news3]
  }

  func getMilkyWayNews() -> [News] {
    let news1 = News(dateString: "April 7, 2340", title: "Earth Sized Asteroid Travelling at Light Speed", descriptionText: "An Earth sized asteroid, KP-4148815 has been circling the center of the Milky Way from the Milk Way's outer spiral since the dawn of the galaxy.")
    let news2 = News(dateString: "April 7, 2340", title: "An Odd Comet", descriptionText: "An odd comet is travelling through space. The streaks of ice is creating a purple glow")
    return [news1, news2]
  }
}
