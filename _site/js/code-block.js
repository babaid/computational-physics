import { Tabs, TabList, Tab, TabPanels, TabPanel } from "@reach/tabs";
import "@reach/tabs/styles.css";

const MultiLangCodeBlock = ({ children }) => {
  const codeTitles = children.map(
    (child) => child?.props?.children?.props?.title
  );
  const tabLabels = children.map((child) =>
    child?.props?.children?.props?.className.replace(/language-/, ``).split(` `)
  );

  const [tabIndex, setTabindex] = useState(0);
  const [title, setTitle] = useState(codeTitles[0]);

  const handleTabsChange = (index) => {
    setTabindex(index);
    setTitle(codeTitles[index]);
  };

  return (
    <Tabs index={tabIndex} onChange={handleTabsChange}>
      <div sx={{ display: "flex", variant: `styles.CodeBlock.title` }}>
        <div sx={{ flex: 1 }}>{title}</div>
        <TabList
          sx={{
            color: "mutedText",
            "[data-selected]": { color: "mutedPrimary" },
          }}
        >
          {tabLabels.map((label) => (
            <Tab key={label}>{label}</Tab>
          ))}
        </TabList>
      </div>
      <TabPanels>
        {children.map((child) => {
          // split off title so the CodeBlock from the theme doesn't render a header, this component does that
          const { title, ...blockProps } = child.props.children.props;
          return (
            <TabPanel key={blockProps.className}>
              <CodeBlock {...blockProps} />
            </TabPanel>
          );
        })}
      </TabPanels>
    </Tabs>
  );
};