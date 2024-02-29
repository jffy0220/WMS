import * as React from 'react';

// We will change this later on to our expected Order data
interface Data {
    id: number;
    calories: number;
    carbs: number;
    fat: number;
    name: string;
    protein: number;
}

type Order = 'asc' | 'desc';

interface EnhancedTableProps {
    numSelected: number;
    onRequestSort: (event: React.MouseEvent<unknown>, property: keyof Data) => void;
    onSelectAllClick: (event: React.ChangeEvent<HTMLInputElement>) => void;
    order: Order;
    orderBy: string;
    rowCount: number;
}

function EnhancedTableHead(props: EnhancedTableProps) {
    const { onSelectAllClick, order, orderBy, numSelected, rowCount, onRequestSort } = props;

    const createSortHandler = ( property: keyof Data ) => (event: React.MouseEvent<unknown>) => {
        onRequestSort(event, property);
    }

    return (
        <TableHead>
            <TableRow>
                <TableCell padding="checkbox">
                    <Checkbox
                        color="primary"
                        indeterminate={numSelected > 0 && numSelected < rowCount }
                        checked={rowCount > 0 && numSelected === rowCount }
                        onChange={onSelectAllClick}
                        inputProps={{
                            'aria-label': 'select all desserts',
                        }}
                    />
                </TableCell>
                
            </TableRow>
        </TableHead>
    )
}

export default function Order() {
    return (
        <>
            <h1>Hello World</h1>
        </>
    )
}