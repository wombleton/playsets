(function() {
  Ext.regModel('Playset', {
    fields: ['key', 'splash', 'title', 'summary', 'instant_setup', 'pitch', 'locations', 'needs', 'relationships', 'objects', 'tags']
  });
  Ext.regModel('Item', {
    fields: ['group', 'text']
  });
  new Ext.data.Store({
    getGroupString: function(record) {
      return record.get('title')[0].toUpperCase();
    },
    model: 'Playset',
    sorters: [
      {
        property: 'title'
      }
    ],
    sortOnLoad: true,
    storeId: 'playsets'
  });
  Ext.ns('FSC.data');
  FSC.data.ItemStore = Ext.extend(Ext.data.ArrayStore, {
    constructor: function(cfg) {
      if (cfg == null) {
        cfg = {};
      }
      cfg = Ext.applyIf(cfg, {
        model: 'Item'
      });
      return FSC.data.ItemStore.superclass.constructor.call(this, cfg);
    },
    getGroupString: function(record) {
      return record.get('group');
    },
    sorters: [
      {
        property: 'text'
      }
    ]
  });
  Ext.StoreMgr.get('playsets').add({
    title: 'Main St',
    splash: 'main-st.png',
    relationships: [
      {
        name: 'Family',
        values: ['Parent-In-law / son or daughter-in-law', 'Cousins, or aunt/uncle and niece/nephew', 'Siblings', 'Parent / child or stepchild', 'Grandparent / grandchild', 'Distant / unusual / unofficial relatives']
      }, {
        name: 'Work',
        values: ['Former co-workers', 'Current co-workers', 'Supervisor / employee', 'Tradesman (mechanic, plumber, decorator, landscaper) & client', 'Salesman / customer', 'Professional (pastor, doctor, lawyer, dentist, drug dealer) & client']
      }, {
        name: 'Friendship',
        values: ['Manipulator / victim', 'Old buddies', 'Drug friends', 'Friendly rivals', 'Friends with benefits', 'Bitter social adversaries (church friends)']
      }, {
        name: 'Romance',
        values: ['Former spouses', 'Current spouses', 'Life-long crush / object of crush', 'One-time fling', 'Lovers', 'Former lovers']
      }, {
        name: 'Crime',
        values: ['Corrupt official / local big shot', 'Gambler / bookie', 'Thieves (shoplifters, burglars, car thieves)', 'Con man / mark', 'Hoodlums (racketeers, knuckleheads, delinquents)', 'Drug people (dealers, manufacturers, distributors)']
      }, {
        name: 'Community',
        values: ['Elected officials (Aldermen, mayor, commissioner)', 'Civic volunteers (election officials, chamber, clubs)', 'Church volunteers (deacons, Sunday school teacher)', 'Rec league, minor league, pick-up team sports', 'Case worker, parole officer, guardian ad litem / client', 'AA/Narcanon sponsor / participant']
      }
    ],
    needs: [
      {
        name: 'To get out',
        values: ['...of this town, before they realize you took it', '...of this town, to escape family', '...of the gang', '...of a relationship with a lover', '...of the obligation to a frail relative in your care', '...of a crushing debt coming due']
      }, {
        name: 'To get even',
        values: ['...with the bad people, who think they are so tough', '...with this town, for what it has turned you into', '...with a police officer', '...with a family member', '...with a co-worker', '...with a rival']
      }, {
        name: 'To get rich',
        values: ['...through stealing a drug stash', '...through robbing a business', '...through tricking a handicapped guy', '...through the death of an elderly person', '...through political back-scratching', '...through a misplaced suitcase full of cash']
      }, {
        name: 'To get respect',
        values: ['...from this town, by bringing down the machine', '...from this town, by proving your convictions', '...from your lover, by taking the fall', '...from the police, by turning in your own kin', '...from a family member, by rescuing them from ruin', '...from yourself, by finally doing it once and for all']
      }, {
        name: 'To get the truth',
        values: ['...about why they are all so shut-mouthed', '...about the Sheriff’s political corruption', '...about why he really came here', '...about what she did behind The Patio', '...about your real parents', '...about the mistake that haunts you']
      }, {
        name: 'To get laid',
        values: ['...to get it over with', '...by that sweet thing you’ve been thinking on', '...because you need the raise that badly', '...by an old lover, to start over', '...by an old lover, to further your scheme', '...by your sweetheart, who is acting squirrelly']
      }
    ],
    locations: [
      {
        name: 'Main Street',
        values: ['Peace Haven Church', 'El Perro Alto MexicanRestaurant', 'Royall’s Drug Store: Pharmacy in the back, soda fountain up front', 'Shafter and Hazelbrook, LLC, the only lawyers in town', 'Commercial Bank, the only bank in town', 'Vantage Services, medical claims processor']
      }, {
        name: 'Commerce Street',
        values: ['Suds and Duds, coin operated laundromat', 'Municipal building, police station, courts and City Hall', 'Family Medical Clinic, the only doctor in town', 'New Outlook, tanning salon and weight loss center', 'The Patio, a movie picture house', 'Bill Rivers’ Pool Room, for pool and illegal gambling']
      }, {
        name: 'Out by the Interstate',
        values: ['Chicken Hut, fast food restaurant', 'Davenport’s Tire and Tractor, tire shop and tractor repair', 'Rose’s Village Motel, convenient to the highway', 'The Quik-Pik, gas station and convenience store', 'Durable Paper Goods, paper bag manufacturing plant', 'Accurate Automotive, used cars']
      }, {
        name: 'Up Center Road',
        values: ['J&K Gravel: Gravel, stone, and quarried materials', 'The old fish house, an abandoned roadhouse', 'Center Road Animal Care, large animal veterinarian', 'Lyman C. Mills Consolidated High School', 'Spiller’s, funeral services since 1911', 'Charles Green Landscaping, lawn care and excavation']
      }, {
        name: 'Out and About',
        values: ['Town parking lot beside the freight tracks', 'Red Run State Park', 'A farmer’s field out past Surry Avenue', 'The ball field', 'Woods up around Hickory Terrace', 'Construction site next to Accurate Automotive']
      }, {
        name: 'Residences',
        values: ['Van parked behind Royall’s', 'Trailer out back of the high school', 'Apartment above Suds and Duds', 'Farmhouse up Center Road', 'Split-level ranch on Surry Avenue', 'Mansion out by Hickory Terrace']
      }
    ],
    objects: [
      {
        name: 'Untoward',
        values: ['Porn stash / sex gear', 'Welfare check / food stamps', 'Garage full of Amway products', 'Mink farm', 'Klan outfit / hate paraphernalia', 'Eviction notice']
      }, {
        name: 'Transportation',
        values: ['Golf cart', 'New pickup truck', 'Panel truck', 'Small plane', 'Pontoon party boat', 'Dirt bike']
      }, {
        name: 'Weapon',
        values: ['Shotgun', 'Machete', 'Poisonous snake', 'Handgun', 'Pipe bomb', 'Firefighter’s Halligan tool']
      }, {
        name: 'Information',
        values: ['Secret recipe', 'An overheard conversation', 'Legal records', 'Love letter', 'List written in a Christmas card', 'Photographs']
      }, {
        name: 'Valuables',
        values: ['Drug stash', 'Mason jar full of gold coins', 'Comic book collection', 'Vintage car', 'Purebred animal', 'Suitcase full of cash']
      }, {
        name: 'Sentimental',
        values: ['Newborn baby', 'War memorabilia', 'Roadside accident shrine', 'Mathematics trophy', 'Wedding ring', 'Heirloom silver tea set']
      }
    ],
    instant_setup: "<h2>Relationships</h2>\n<h3>For three players...</h3>\n<ul>\n  <li>Family: Siblings</li>\n  <li>Romance: Former spouses</li>\n  <li>Crime: Corrupt official / local big shot</li>\n</ul>\n<h3>For four players, add...</h3>\n<ul>\n  <li>Friendship: Drug friends</li>\n</ul>\n<h3>For five players, add...</h3>\n<ul>\n  <li>Work: Professional and client</li>\n</ul>\n<h2>Needs</h2>\n<h3>For three players...</h3>\n<ul>\n  <li>To get even: With a rival</li>\n</ul>\n<h3>For four or five players, add...</h3>\n<ul>\n  <li>To get out: Of a crushing debt coming due</li>\n</ul>\n<h2>Locations</h2>\n<h3>For three, four or five players...</h3>\n<ul>\n  <li>Main Street: El Perro Alto Mexican Restaurant</li>\n</ul>\n<h2>Objects</h2>\n<h3>For three or four players...</h3>\n<ul>\n  <li>Valuables: Suitcase full of cash</li>\n</ul>\n<h3>For five players, add...</h3>\n<ul>\n  <li>Weapon: Poisonous snake</li>\n</ul>"
  });
  Ext.StoreMgr.get('playsets').add({
    title: 'Boomtown',
    splash: 'boomtown.png',
    relationships: [
      {
        name: 'Family',
        values: ['Parent / son- or daughter-in-law', 'Cousins', 'Siblings', 'Parent / child or stepchild', 'Uncle/nephew or aunt/niece', 'Unrelated, but close as blood']
      }, {
        name: 'Work',
        values: ['Ranch hands', 'Miners', 'Supervisor / employee', 'Tradesman / customer (wheelwright, barber)', 'Salesman / customer (snake oil, mine gear, bibles)', 'Professional / client (pastor, doctor, lawyer, banker)']
      }, {
        name: 'The Past',
        values: ['Criminal and detective', 'Grew up together back East', 'Reformed criminals', 'War adversaries', 'Both married to same spouse (sequential or tandem?)', 'Bad family blood']
      }, {
        name: 'Romance',
        values: ['Former spouses', 'Current spouses', 'Unvarnished lust', 'One-time fling', 'Mail-order bride and her groom', 'Former lovers']
      }, {
        name: 'Crime',
        values: ['Crime boss and toady', 'Gamblers', 'Thieves (yeggs, burglars, horse  thieves)', 'Faith healer and patient', 'Outlaws (bad men, pistoleros, roughnecks)', 'Chinese opium seller / addict']
      }, {
        name: 'Community',
        values: ['Elected officials (mayor, judge, register of deeds, assayer)', 'Society (temperance league, brass band, vigilantes)', 'Church volunteers (lay readers, sexton and gravedigger)', 'Company / citizen (railroad or mine and shareholder)', 'Government / citizen (Indian agent, tax assessor)', 'Sheriff and deputy']
      }
    ],
    needs: [
      {
        name: 'To get free',
        values: ['...of this town, before everyone finds out about you', '...of a family obligation', '...of a business commitment', '...of a relationship with a lover', '...of your lot in life', '...of a crushing debt coming due']
      }, {
        name: 'To get even',
        values: ['...with this town, and its small-minded inhabitants', '...with the local crime boss', '...with the Sheriff', '...with a family member', '...with the Chinese', '...with a rival']
      }, {
        name: 'To get rich',
        values: ['...through robbing a stagecoach', '...through robbing a business', '...through fraud and trickery', '...through buying various officials', '...through violence', '...through a misplaced trunk full of bullion']
      }, {
        name: 'To get respect',
        values: ['...from this town, by bringing down the machine', '...from this town, by showing everybody who’s boss', '...from your lover, by proving yourself', '...from the sheriff, by ratting out your friends', '...from a family member, by rescuing them from ruin', '...from yourself, by finally doing it once and for all']
      }, {
        name: 'To get away',
        values: ['...from the baying hounds of the law', '...with murder', '...from hard-riding vengeance', '...from an honest woman, ruined', '...with your reinvention of yourself', '...with a magnificent swindle']
      }, {
        name: 'To get laid',
        values: ['...by anyone, anywhere, to dull the pain', '...by your ticket out of this burg', '...by an ambitious and beautiful saloon girl', '...to prove them all wrong', '...by your friend’s spouse, to further your agenda', '...so you don’t die a virgin']
      }
    ],
    locations: [
      {
        name: 'Residences',
        values: ['A filthy buckboard wagon with a ragged awning and barrels for walls', 'A tidy Sears-bought house, crisply painted', 'A permanent room in the Belle-Union Boarding House', 'A gaudy mansion next to the dirt platted as a park', 'The opium den behind the White Star Laundry', 'A squalid apartment above the newspaper office']
      }, {
        name: 'The Bradford Hotel',
        values: ['The storm cellar', 'The clerk’s room, safe, and freight office', 'The brothel billiard parlor', 'The saloon', 'A bar girl’s crib', 'The Governor’s Suite']
      }, {
        name: 'The decent part of town',
        values: ['The Commercial Bank', 'Sinclair’s Dry Goods and Mercantile', 'The Territorial Sentinel newspaper office and print shop', 'First Church of Christ, Redeemer', 'The railroad depot and telegraph office', 'E.A. Lodge, Dentist']
      }, {
        name: 'Across the tracks',
        values: ['The Fraternal Order of the Frontier Lodge Hall', 'White Star Chinese laundry', 'The Belle-Union Boarding House', 'Town jail', 'Eyck’s Tack, Harness, and Stable', 'Boot Hill']
      }, {
        name: 'Up in the hills',
        values: ['The Chinese camp', 'The hanging tree', 'The wagon road', 'Gold Creek shanty town', 'The Circle S Ranch', 'The secret cave']
      }, {
        name: 'Indian Country',
        values: ['The burnt-out log cabin', 'The bandit hideout', 'The Hunkpatila Sioux camp', 'The prospector’s hut', 'Pilot Rock', 'The Presbyterian mission at Broken Arrow']
      }
    ],
    objects: [
      {
        name: 'Untoward',
        values: ['A three dollar “all night” brothel token', 'A mortician’s black bag and a jug of phenolic acid', 'A vulcanized rubber “womb veil”', 'The skeleton of a Mescalero Apache', 'A Spiritualist’s bag of magician’s tricks', 'An abortionist’s tools']
      }, {
        name: 'Transportation',
        values: ['A Kansas-Pacific railroad car', 'A four-horse mail coach', 'A safety bicycle', 'A railroad hand car', 'The guarded mine payroll mud coach', 'A St. Louis and San Francisco railroad boxcar']
      }, {
        name: 'Weapon',
        values: ['A blacksmith’s tongs', 'A Sharps lever-action rifle', 'A matched set of Colt revolvers', 'A Sioux war club', 'A crate of old dynamite, weeping nitroglycerin', 'A 12-pound Mountain Howitzer']
      }, {
        name: 'Information',
        values: ['An assay note on the minerals in Circle S Ranch soil', 'An overheard conversation about the Gold Creek strike', 'A freedman’s manumission papers', 'A lady’s diary', 'A faded wanted poster', 'A contract with the Pinkerton Detective Agency']
      }, {
        name: 'Valuables',
        values: ['The deed to Sinclair’s Dry Goods and Mercantile', 'A promissory note for two thousand dollars', 'A wad of Federal postage stamps wrapped in a kerchief', 'A cage of Napaeozapus insignis, Woodland jumping mice', 'A heavy sack of gold dust', 'The cashbox from the Bradford Hotel brothel']
      }, {
        name: 'Sentimental',
        values: ['A newborn baby', 'A pretty locket with a lock of hair inside', 'A tiny oil portrait of a handsome soldier', 'A tear-stained love letter', 'An engraved silver goblet', 'A dying man’s last words']
      }
    ],
    instant_setup: "<h2>Relationships</h2>\n<h3>For three players...</h3>\n<ul>\n  <li>Family: Unrelated, but close as blood</li>\n  <li>Crime: Crime boss and toady</li>\n  <li>Romance: Mail-order bride and her groom</li>\n</ul>\n<h3>For four players, add...</h3>\n<ul>\n  <li>Community: Government / citizen</li>\n</ul>\n<h3>For five players, add...</h3>\n<ul>\n  <li>The Past: Both married to same spouse</li>\n</ul>\n<h2>NEEDS</h2>\n<h3>For three players...</h3>\n<ul>\n  <li>To get free: of a relationship with a lover</li>\n</ul>\n<h3>For four or five players, add...</h3>\n<ul>\n  <li>To get away: From hard-riding vengeance</li>\n</ul>\n<h2>Locations</h2>\n<h3>For three, four or five players...</h3>\n<ul>\n  <li>The Bradford Hotel: The saloon</li>\n</ul>\n<h2>Objects</h2>\n<h3>For three or four players...</h3>\n<ul>\n  <li>Information: An assay note on the minerals in Circle S Ranch soil</li>\n</ul>\n<h3>For five players, add...</h3>\n<ul>\n  <li>Sentimental: A newborn baby</li>\n</ul>"
  });
  Ext.ns('FSC.views');
  FSC.views.Index = Ext.extend(Ext.TabPanel, {
    constructor: function(cfg) {
      if (cfg == null) {
        cfg = {};
      }
      cfg = Ext.applyIf(cfg, {
        activeItem: 0,
        items: {
          cls: 'playset-index',
          grouped: true,
          indexBar: true,
          itemTpl: '{title}',
          listeners: {
            itemtap: function(view, index) {
              var panel, record;
              record = this.store.getAt(index);
              panel = new FSC.views.Show({
                record: record
              });
              this.add(panel);
              return this.setActiveItem(panel);
            },
            scope: this
          },
          store: 'playsets',
          title: 'Playsets',
          xtype: 'list'
        },
        layout: 'card',
        store: Ext.StoreMgr.get('playsets')
      });
      FSC.views.Index.superclass.constructor.call(this, cfg);
      Ext.StoreMgr.get('playsets').sort();
      return this.on('cardswitch', function(container, newCard, oldCard, index) {
        if (index === 0) {
          return this.remove(oldCard, true);
        }
      }, this);
    },
    grouped: true,
    indexBar: true
  });
  Ext.ns('FSC.views');
  FSC.views.Show = Ext.extend(Ext.Carousel, {
    constructor: function(cfg) {
      var instant, instant_setup, items, locations, needs, objects, record, relationships, splash, splash_page;
      if (cfg == null) {
        cfg = {};
      }
      record = cfg.record;
      items = [];
      splash = record.get('splash');
      if (splash) {
        splash_page = new FSC.views.Splash(splash);
      }
      instant = record.get('instant_setup');
      if (instant) {
        instant_setup = new FSC.views.InstantSetup(instant);
      }
      relationships = new FSC.views.List(record, 'relationships');
      needs = new FSC.views.List(record, 'needs');
      locations = new FSC.views.List(record, 'locations');
      objects = new FSC.views.List(record, 'objects');
      cfg = Ext.applyIf(cfg, {
        items: _.compact([splash_page, needs, relationships, locations, objects, instant_setup]),
        title: record.get('title')
      });
      FSC.views.Show.superclass.constructor.call(this, cfg);
      return this.doComponentLayout();
    }
  });
  FSC.views.Splash = Ext.extend(Ext.Panel, {
    constructor: function(img) {
      return FSC.views.Splash.superclass.constructor.call(this, {
        cls: 'splash-page',
        html: "<img class=\"background\" src=\"/images/" + img + "\">\n<img class=\"swipe\" src=\"/images/swipe.png\">"
      });
    }
  });
  Ext.ns('FSC.views');
  FSC.views.InstantSetup = Ext.extend(Ext.Panel, {
    constructor: function(html) {
      return FSC.views.InstantSetup.superclass.constructor.call(this, {
        cls: 'instant-setup',
        html: html
      });
    }
  });
  Ext.ns('FSC.views');
  FSC.views.List = Ext.extend(Ext.Panel, {
    constructor: function(record, property) {
      var cfg;
      cfg = {
        items: {
          grouped: true,
          itemTpl: '<div class="playset-item"><div class="dice-roll dice-roll-{index}"></div><div class="item-text">{text}</div></div>',
          singleSelect: true,
          store: this.createStore(record, property),
          xtype: 'list'
        },
        layout: 'fit'
      };
      return FSC.views.List.superclass.constructor.call(this, cfg);
    },
    createStore: function(record, property) {
      var store;
      store = new FSC.data.ItemStore();
      _.each(record.get(property), function(val, i) {
        var group;
        group = "" + (i + 1) + " " + val.name;
        return _.each(val.values, function(v, i) {
          return store.add({
            group: group,
            index: i + 1,
            text: v
          });
        });
      });
      return store;
    }
  });
  Ext.setup({
    tabletStartupScreen: 'fiasco.svg',
    phoneStartupScreen: 'fiasco.svg',
    icon: 'icon.png',
    glossOnIcon: true,
    onReady: function() {
      return new FSC.views.Index({
        fullscreen: true
      });
    }
  });
}).call(this);
