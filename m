Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E645C36A2BA
	for <lists+linux-nvdimm@lfdr.de>; Sat, 24 Apr 2021 21:01:33 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1C169100ED4BB;
	Sat, 24 Apr 2021 12:01:31 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.79; helo=aserp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 15ACC100ED4A0
	for <linux-nvdimm@lists.01.org>; Sat, 24 Apr 2021 12:01:27 -0700 (PDT)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13OIu7UV007751;
	Sat, 24 Apr 2021 19:00:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=R7FGZ8im7oXTKvTP1EPhWQWahkvjHTgW3XlC+Mbzr4w=;
 b=M52IccfqFmDIpoMJdGcmcwUCR4OqYndsPuN87OcLA7Fv+uWJIFIwCcjZw9lnLCnrhXgK
 QpnCxZlwtig7coK4/dlUNS9RmVU/BBm41ZAauHF+zNVfMnlg63PkXdtD3C8Tt8epgs6/
 iFqaeVxWLsYnW0MNMcCQXfUsHa6SgSoNUjw9jDeQcBM0ByfKluHUkWrwz4nRyMu1N9Bi
 i8qYoz4ls3L8mLpDMjLR3EBricM8t7R02cDHLzdFjmfD+5hNlHT3M2EUFOgjzhyzAM0L
 jUFIURnc3SZ+48AFn5OgpF6fHmNfqEJ4+N+TXf+jvZ0EUfaw8G6DRJavEPxfGzOO0A9A 0A==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by aserp2130.oracle.com with ESMTP id 3848ubrt2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Apr 2021 19:00:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13OJ0AOs162545;
	Sat, 24 Apr 2021 19:00:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by userp3020.oracle.com with ESMTP id 384anj3wu5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Apr 2021 19:00:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxpKiaWE2z4EWMqAPIfy52TmjB0kjHH8Wrh7seBtgtLONHqYeass+c8nbN6drtc/IjwwlklKehpPUCBGAEtqrDoAn6a7jLRpbp3dS56cvGXkCNfjMJPl7n/FADfpemWFI3Pa891q/fg5kOQRpGQFF6elNZDliyhMcdtIqQ7FrxbQ7c+Qg4oLME6oGmbpUXZ5xbwwhGUXVNArevm8ucFi0d9N18Zp3MJ6wfH0ZkS6j/az1AhM05NjQT7XnBfioXUOF88gs79ns3X/mEhFnBw4n0X9309SJpEXj4kGhIL+O9qogO0ggBh7gyx7oj1eGWXUaqXwgf1TRjcmsfmH4ScxcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7FGZ8im7oXTKvTP1EPhWQWahkvjHTgW3XlC+Mbzr4w=;
 b=kZCojh3VsTS9wQFZXQWX2FUftvYdpgIoyZPPy9PDoLYF55Nd/65WQUVlNnO/m9CDobJt2z3DU8aESGO394AByA8ucRpYyxzqufCc9kiNgxPv/yP+utURBDbfY8bzZygFK3IzSPtCxlGUdjq2DCqILrcVtm1uxHWtAazDqDI7AKhuKPl608HZlxzXa0Qf40u1b0Rl0+Lifl79FR9yzc0dJYkJoI8VeFwXUUDlN1WxD1Ut8FK2yXSkX9nZyIzNG8OfKRBAneIBK8xm38rL5TfU8oQ2zEIKUqW97I63BpGKcIpcx2ECPXB6ZQPuTnMdCyEyYJ5z9GHooumZqpL+pHLZMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7FGZ8im7oXTKvTP1EPhWQWahkvjHTgW3XlC+Mbzr4w=;
 b=K4clJYg++ALoqlsCcJN+NMnwnSFsy7MpSH83JZxfPHu9hEmwenhVZDNqDqT6l1I/OU6Q73lGnsqZoCEdATEP4JKdLC+BaB1gtyvPi7MsAogkAu84HKjYUQhPBcIqvcjo+NG88NqLvizDzputoJ0QYa0DlLSTbsel27XBUgIEJmA=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BY5PR10MB4178.namprd10.prod.outlook.com (2603:10b6:a03:210::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Sat, 24 Apr
 2021 19:00:48 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::507f:a466:3318:65db]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::507f:a466:3318:65db%7]) with mapi id 15.20.4042.026; Sat, 24 Apr 2021
 19:00:48 +0000
Subject: Re: [PATCH v1 01/11] memory-failure: fetch compound_head after
 pgmap_pfn_valid()
To: Dan Williams <dan.j.williams@intel.com>
References: <20210325230938.30752-1-joao.m.martins@oracle.com>
 <20210325230938.30752-2-joao.m.martins@oracle.com>
 <CAPcyv4hCRZ9Dacmbv8kP-4g4DkD6HvO0OSzzaXWLQhKa-r_fXQ@mail.gmail.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <e0a7336a-89a1-050b-2b5c-30afdfe2b876@oracle.com>
Date: Sat, 24 Apr 2021 20:00:40 +0100
In-Reply-To: <CAPcyv4hCRZ9Dacmbv8kP-4g4DkD6HvO0OSzzaXWLQhKa-r_fXQ@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [94.63.165.137]
X-ClientProxiedBy: LO2P265CA0253.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::25) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.85] (94.63.165.137) by LO2P265CA0253.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:8a::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25 via Frontend Transport; Sat, 24 Apr 2021 19:00:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecda7e46-409e-4b5e-bd91-08d9075345ce
X-MS-TrafficTypeDiagnostic: BY5PR10MB4178:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BY5PR10MB4178453B7EF1E41A87462E73BB449@BY5PR10MB4178.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Hj7qyp5oenJVp1AcTOnFkKcEDCtXjQcuzPgGxv56dAD0t50qSxQB7ojRI9PwXCrIVnOqSzgDgs9qWnB0doA3OATmB6MT+iJRyYSluCMfBn21xqY7WYkxmbqB4dla+qp7UrrEWJnMD3xZM0BBcelnE9VNS15NlXXo0LuYcTBk1PyvkIaY7KW7pMrbtAEK8fb/SnH/lTG6B8wNCitiHs4nC6qdd1I5TnLXLEz9wgJMgIFBVVaDpj4rMcfOWiQWGkHNTvopteOUwrfiRTHYAxe5Hb125eUDCVosE/xcJuPLxvBG6w7XlI4iXg45rA03cKD6vQifGR4EfncGJmCfAfpOpNDWAXGkcIxyzRzn5HDxOeBL/WhCr93uOTxVVRzxZmS8rg6/03800qzRIugxjas/CKhrTA9cTHKNgsjfMeDKsyINNGbtgHpnjAD/8V7x9rXPaiz2g/IJeMv9hZygwBpAch3MOahDwpeyxFTg9PiKb/DJJ3Zm69RXsGuqy5vXZi4nSyJKIKzC2V246Dg/uYZBjO7jH7rtSfvvB+fhZ102l1IVO9eb3hh5ld9+GGw8O41s2g+PqI/XekpMxaKIxStSRcur+5q3vOeE82yp39DdW3+Koqf0zBiKxjAUE+g+TwxnFovOcfnAAEB4PkXKbfndHg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(136003)(346002)(39860400002)(16576012)(66946007)(66476007)(66556008)(186003)(16526019)(478600001)(83380400001)(8936002)(54906003)(26005)(316002)(4326008)(6916009)(2616005)(956004)(36756003)(6666004)(31696002)(86362001)(5660300002)(38100700002)(8676002)(6486002)(53546011)(2906002)(31686004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?utf-8?B?TlJRc3h4OCtubjd4cVhYcHV0T1l4MWtmb0FYTFlYVHhiYWY0SkJWNjIrT2ky?=
 =?utf-8?B?cnVZZHpVTmp6WnRxM2llUktwenIwWDFCdDF5T0M4bXB2NHBxOEIwL1IxUUFk?=
 =?utf-8?B?eFN0b0tpTGxsZ3JuL0hycHlQeWFTWjUxdGJndVkxTTl1QkNHTlJncTNBY29w?=
 =?utf-8?B?R1gyQnI3dVg3dTFFdWxvdUx4QUhod1hicWxTWlN4K2QzU3o3TXhFQTZsRHd1?=
 =?utf-8?B?d3VUYVhVTDg3OWNQUW5jeUJlb3dsbWpkcU9mdTYrdUVTTWwyUmFHakpCdFgr?=
 =?utf-8?B?K3hKWnhpaWNrY0Y3Y3g5ZFFkMWVvaFp6b0dTYjFmWWp6YXRaNk0rRkM4ZE5N?=
 =?utf-8?B?QVUzMlhMSW5uUlVhaGlqekUrZ0xpNnhWZ3VmRTdrdHFQS1VVMTlvcmJHOFJv?=
 =?utf-8?B?d09VSEoxc3pTU1dSVGNIalFDL1k1Z0h2NExjRThIcStvT2ZaZUdjZGp0UjJu?=
 =?utf-8?B?VzYyRFJ1RmZKeXQ0ZGZMdXcrS05wdmpyd3NIenE1akdQV2J6Q0lxZnNlTkNZ?=
 =?utf-8?B?QW04dUw3dktGcitDa0VDTEs0NTJ1K0RRR2k4ZjNUWkFxd2dwbGM4WHFadzRL?=
 =?utf-8?B?UXRTSDVJSThtclRSd2d5TEZ2VysvNTJuZ3A0cWpINkpZUlBvdnNVUDB0SzQw?=
 =?utf-8?B?UzNiVWlRUy9ZZEI5aDAzdmUxZG5ObFZUeFN2eWVqNHJDNXBnNUY1YVk0OFJE?=
 =?utf-8?B?aUxPdjV3emd2cXdxSWpocUR5K1I0dzJUOCtiNUkySG1lQnpTZkltNmZQb0NW?=
 =?utf-8?B?czFuUExhbDJraXVpOEdnbHNZc2JmenA2ZGNMdWhzVHhYSTR4Qlhpd053YTI5?=
 =?utf-8?B?YzU0UWlRazRhUW1id3ZWTDVDUlJVRnZKa2ZZdHcrODdHbi9TN2pFSUY5Y0d2?=
 =?utf-8?B?QnE0NFlKYTlVcjRJeWo5Vm5EWGhrWnp2T0kwOW95UEE2d0lCeE91enVoTGww?=
 =?utf-8?B?K21qRldhQW8wdzVONjV1RytUWWlDMmVSOHVzZUFNeHo3bVpiVGNEcHV1c3Bv?=
 =?utf-8?B?N3BQWFVtbUhXSGlCY3UwK1M1ZlBwYjE1QnFlNG03TTFOUEpBS0JnUWJNb1FP?=
 =?utf-8?B?a0RiTnBwSWlPakdkUVkwc3BiYmZTS2dDdWhzYnRMVTNiYWhxU3pNTEVPTzho?=
 =?utf-8?B?ZzlLRTNvRFRkWXJyV1BlSjNsZnZhcWVyYS85a09wVU5aTGNpd202NE1NUUpE?=
 =?utf-8?B?akVWQjR3UG5kRTZKRjlidWF6bnIxK3lReFpnSktrUHZ1Nm5wbVl6UUJiSzFv?=
 =?utf-8?B?NnBLVnJ1cjdxM1F5TkRpSFA0dVBYZ1hnRFZGdDNOMHpNNWJMc05RWXJVVDI4?=
 =?utf-8?B?N0JRUk8weEtlV2x4T0VqZkVUY2kxeVU4MEdMZjFDNmZFK3hmU2JMaFNkejZv?=
 =?utf-8?B?ckdSWDdGcWlXZkpQcUtlSG82V0VtcEt2Umd5WTViaVJ2bDdwM2tRVXZNbTVa?=
 =?utf-8?B?MjFuMlpSeW1DM2M4SjdqaWNBN09sTTBBQlpGV2xiVFpmZ2NEM2xONjFPUFlp?=
 =?utf-8?B?UzMvK1VFZFg2b1kyajR2Myt3b1pRWXpFODdiVzBIRHZGVUZDU1BqcHlWQjJs?=
 =?utf-8?B?ei91c3F2eWFBdDFaYkwreWJwQ3hNai9IVmtyUjlpSWtMM3laVWl4WVE4Sm15?=
 =?utf-8?B?OG9DZUgrN0U0dm1leUVIVis2b255eFk4QktYUTVZemI1cGZ2U2NEM096Z21G?=
 =?utf-8?B?RHNXa1dXRzgxTDBIV295anRRUCtBVEx3b0VuRDRac01IRHdGWkVjMC83VjlO?=
 =?utf-8?Q?bZLm7YXOBLIqU34zAWxeBDbc6LjDnzyO5cgGHCu?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecda7e46-409e-4b5e-bd91-08d9075345ce
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2021 19:00:48.6141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5n9QDH59lg8nh3YbGNv46zELD+CbBye4j+8DzKp44/O2vXvSCIQYbBQYdrqs4Vr1TOlwv9tLjq23o3J3pNOC7E75ouir/6UM8HKI9Iy/L9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4178
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9964 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104240143
X-Proofpoint-GUID: uxUL150WY7woswKV2pAEy8gxPbRw0sQS
X-Proofpoint-ORIG-GUID: uxUL150WY7woswKV2pAEy8gxPbRw0sQS
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9964 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104240142
Message-ID-Hash: 44BRQRMIDCBJK3V576QC2AWXGMTXWJFW
X-Message-ID-Hash: 44BRQRMIDCBJK3V576QC2AWXGMTXWJFW
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Jane Chu <jane.chu@oracle.com>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/44BRQRMIDCBJK3V576QC2AWXGMTXWJFW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 4/24/21 1:12 AM, Dan Williams wrote:
> On Thu, Mar 25, 2021 at 4:10 PM Joao Martins <joao.m.martins@oracle.com> wrote:
>>
>> memory_failure_dev_pagemap() at the moment assumes base pages (e.g.
>> dax_lock_page()).  For pagemap with compound pages fetch the
>> compound_head in case we are handling a tail page memory failure.
>>
>> Currently this is a nop, but in the advent of compound pages in
>> dev_pagemap it allows memory_failure_dev_pagemap() to keep working.
>>
>> Reported-by: Jane Chu <jane.chu@oracle.com>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>  mm/memory-failure.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 24210c9bd843..94240d772623 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -1318,6 +1318,8 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>>                 goto out;
>>         }
>>
>> +       page = compound_head(page);
> 
> Unless / until we do compound pages for the filesystem-dax case, I
> would add a comment like:
> 
> /* pages instantiated by device-dax (not filesystem-dax) may be
> compound pages */
> 
I've fixed up with the comment.

Thanks!
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
