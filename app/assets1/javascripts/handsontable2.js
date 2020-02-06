var dataObject = [
  {
    ingredient: 'Biotin',
    group: 'Biotin',
    weight: '20 g',
    percentage: '4.5%'

  },
  {
    ingredient: 'Biotin',
    group: 'Biotin',
    weight: '20 g',
    percentage: '4.5%'
  },
  {
    ingredient: 'Biotin',
    group: 'Biotin',
    weight: '20 g',
    percentage: '4.5%'
  },
  {
    ingredient: 'Biotin',
    group: 'Biotin',
    weight: '20 g',
    percentage: '4.5%'
  },
  {
    ingredient: 'Biotin',
    group: 'Biotin',
    weight: '20 g',
    percentage: '4.5%'
  },
  {
    ingredient: 'Biotin',
    group: 'Biotin',
    weight: '20 g',
    percentage: '4.5%'
  },
  {
    ingredient: 'Biotin',
    group: 'Biotin',
    weight: '20 g',
    percentage: '4.5%'
  },
  {
    ingredient: 'Biotin',
    group: 'Biotin',
    weight: '20 g',
    percentage: '4.5%'
  },
  {
    ingredient: 'Biotin',
    group: 'Biotin',
    weight: '20 g',
    percentage: '4.5%'
  },

  {
    ingredient: 'Biotin',
    group: 'Biotin',
    weight: '20 g',
    percentage: '4.5%'
  },
  {
    ingredient: 'Biotin',
    group: 'Biotin',
    weight: '20 g',
    percentage: '4.5%'
  },
  {
    ingredient: 'Biotin',
    group: 'Biotin',
    weight: '20 g',
    percentage: '4.5%'
  },

  {
    ingredient: 'Biotin',
    group: 'Biotin',
    weight: '20 g',
    percentage: '4.5%'
  },
  {
    ingredient: 'Biotin',
    group: 'Biotin',
    weight: '20 g',
    percentage: '4.5%'
  },
  {
    ingredient: 'Biotin',
    group: 'Biotin',
    weight: '20 g',
    percentage: '4.5%'
  },

  {
    ingredient: 'Biotin',
    group: 'Biotin',
    weight: '20 g',
    percentage: '4.5%'
  },
  {
    ingredient: 'Biotin',
    group: 'Biotin',
    weight: '20 g',
    percentage: '4.5%'
  },
  {
    ingredient: 'Biotin',
    group: 'Biotin',
    weight: '20 g',
    percentage: '4.5%'
  },
  {
    ingredient: 'Biotin',
    group: 'Biotin',
    weight: '20 g',
    percentage: '4.5%'
  },
  {
    ingredient: 'Biotin',
    group: 'Biotin',
    weight: '20 g',
    percentage: '4.5%'
  },
  {
    ingredient: 'Biotin',
    group: 'Biotin',
    weight: '20 g',
    percentage: '4.5%'
  },
   {
    ingredient: 'Biotin',
    group: 'Biotin',
    weight: '20 g',
    percentage: '4.5%'
  },
  {
    ingredient: 'Biotin',
    group: 'Biotin',
    weight: '20 g',
    percentage: '4.5%'
  },
  {
    ingredient: 'Biotin',
    group: 'Biotin',
    weight: '20 g',
    percentage: '4.5%'
  },
   {
    ingredient: 'Biotin',
    group: 'Biotin',
    weight: '20 g',
    percentage: '4.5%'
  },
  {
    ingredient: 'Biotin',
    group: 'Biotin',
    weight: '20 g',
    percentage: '4.5%'
  },
  {
    ingredient: 'Biotin',
    group: 'Biotin',
    weight: '20 g',
    percentage: '4.5%'
  }  
];
var hotElement = document.querySelector('#translation-its2');
var hotElementContainer = hotElement.parentNode;
var hotSettings = {
  data: dataObject,
  columns: [
    {
      data: 'ingredient',
      type: 'text'
    },
    {
      data: 'group',
      type: 'text'
    },
    {
      data: 'weight',
      type: 'text'
    },
    {
      data: 'percentage',
      type: 'text'
    }   
  ],
  stretchH: 'all',
  width: 1135,
  autoWrapRow: true,
  height: 600,
  maxRows: 100,
  //colWidths: [45, 100, 160, 60, 80, 80, 80],
  rowHeights: 50,
  manualRowResize: true,
  manualColumnResize: true,
  rowHeaders: true,
  colHeaders: [
    'Ingredient',
    'Group',
    'Weight',
    'Percentage'
  ],
  manualRowMove: true,
  manualColumnMove: true,
  contextMenu: true,
  filters: true,
  dropdownMenu: true,

};
var hot = new Handsontable(hotElement, hotSettings);

