Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A90C1388CCE
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 May 2021 13:29:55 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5BF59100EBB97;
	Wed, 19 May 2021 04:29:52 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.79; helo=aserp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 200C4100EC1E3
	for <linux-nvdimm@lists.01.org>; Wed, 19 May 2021 04:29:48 -0700 (PDT)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14JBEJNw151419;
	Wed, 19 May 2021 11:29:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=/nyOFdQT8WhaphGfSvFgRjfjzPkuK22nw9piIetqOgU=;
 b=CbOyXzMP2uFTh5dueN6TcUSDUaxUZ0lyvjWI+5MIW8uVV/cX0GZI80AM5WMawCoJjsi7
 FSUZtu1fo/40KxuK9VAf95IcKtT0kb+9PjWSyr8iNCbo34sCGJubFUfpdoclBzkGHvdj
 YLCIMV3D36c8ebbwfGXFA3IqAPW8JmfoQRaX/5VfmHFmWKzajXwZWHxXQcWWHzUr+Zyi
 xuyDqPReQqhzYEl/A9xvhK5Z9JWAlQuvjCK/KAUX8Kknp0n6LO5unlY4kwDT/YNiWzSS
 OkncTkle2hp6y6Kp7F67p8cUXoTVFgjElp1AAGN5ABdM5ZKrlwhxm8AT7YXRQHMs0IXv rg==
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by aserp2130.oracle.com with ESMTP id 38j3tbhavp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 May 2021 11:29:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14JBGMmm010170;
	Wed, 19 May 2021 11:29:33 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by userp3030.oracle.com with ESMTP id 38megkddc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 May 2021 11:29:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWXNE0CcUry9Kfrkj/eetTqOShOIg68MZXnbPmLdhejQJNk3V79uE+fQksAAR3y/q9gp32KGY4VIzue9vmjNqkvIb7w3uoC+JGCMqNVRbd+MmeDpJKzsXE0P7GrLrr+DnZE5Iq0TmDUVswiX3Z/CoD3K6mrA5RduR5pzo1SXM+3K+TUSLpe+c3LfX2tzk3Yi1rhEaboze+/9Mvnw6qF3uo7mqFB2No3H3ZJmYuA3Z6CzmNOZuhSda9ABIAEtGIG0hWxE8l2/yq1szizrKLB5OPPYULdgu0Eh9/wJSm9/kibiaf3ntnyLyUC57PPlhCbCw51QMAFvLMmOVXJ7nzJn5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nyOFdQT8WhaphGfSvFgRjfjzPkuK22nw9piIetqOgU=;
 b=ggC/+3saTXcQSabPetEWpyU0dLk0ch4gefeXZUzP8CR/KTeAyh/YVHFI0aTwkPtWnP1ZpDBE5e7yIeIjiN+yLH3uwI56eYtthaE7LyHGWG7IAT0S16x5ezI9f3wCYFPhTqec2wQRDP8cHJIOTGPA0YmAN5CkwqtvFW6hNuDPGBm08AAAbAsSzdYDQ8wovtYtyg5uh6YVvTT4NcKkG07E8mEHf5wkGdNXIdo62q4OI7RqncbKoWthly+1KisTRjlQqqCSRcP80EAYcR2U49BqLgaekfXFQMnJZvZ6zluiyh1tk4cUvlYxHQV16JaVHM1Qd9Qwhn5h+Y3SJb6p1+MbGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nyOFdQT8WhaphGfSvFgRjfjzPkuK22nw9piIetqOgU=;
 b=PPHt1/lwBz07hOG7Ngk/Dt66O82nogLn7b+k0gyIRCZBC1pLp+ESK51D5MxI4EEQfr0vYMqjUZNZ2udHYSgUxMhU/hbdwk6AAqWYwmvbUdcLBRtm3ZAGaXvokkwubt3MbwPZSn48Wu8ck8OwtdUMS9XEc8zQYp5WQr/qAA59PXU=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by BL0PR10MB2770.namprd10.prod.outlook.com (2603:10b6:208:7e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 11:29:30 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::8cb1:7649:3a52:236a]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::8cb1:7649:3a52:236a%7]) with mapi id 15.20.4129.032; Wed, 19 May 2021
 11:29:30 +0000
Subject: Re: [PATCH v1 04/11] mm/memremap: add ZONE_DEVICE support for
 compound pages
To: Jane Chu <jane.chu@oracle.com>, Dan Williams <dan.j.williams@intel.com>
References: <20210325230938.30752-1-joao.m.martins@oracle.com>
 <20210325230938.30752-5-joao.m.martins@oracle.com>
 <CAPcyv4gs_rHL7FPqyQEb3yT4jrv8Wo_xA2ojKsppoBfmDocq8A@mail.gmail.com>
 <cd1c9849-8660-dbdc-718a-aa4ba5d48c01@oracle.com>
 <CAPcyv4jG8+S6xJyp=1S2=dpit0Hs2+HgGwpWeRROCRuJnQYAxQ@mail.gmail.com>
 <56a3e271-4ef8-ba02-639e-fd7fe7de7e36@oracle.com>
 <8c922a58-c901-1ad9-5d19-1182bd6dea1e@oracle.com>
 <a394d1a1-32e7-0ae2-a2a1-8ee431ecb479@oracle.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <fa8ad5f1-f923-4393-8771-b2e74abe0f0c@oracle.com>
Date: Wed, 19 May 2021 12:29:25 +0100
In-Reply-To: <a394d1a1-32e7-0ae2-a2a1-8ee431ecb479@oracle.com>
Content-Language: en-US
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO4P123CA0262.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::15) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by LO4P123CA0262.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:194::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25 via Frontend Transport; Wed, 19 May 2021 11:29:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0509ec4-6b8f-4367-58f4-08d91ab95e68
X-MS-TrafficTypeDiagnostic: BL0PR10MB2770:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BL0PR10MB2770108A5C3C076C4E5B7C86BB2B9@BL0PR10MB2770.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	oCbXbM3j4Wc2uUe2JaAxOGwvNlxyyMbrf7oVm17RObI8pdzKToUEoMWwBk2eIEahCg2+bzOaHgEoIo/XgA1a+XoGpcOe2Eo7TaN0TIRh2aDjuULg4/XtIclDphF60S+lbRtfJdNfAzzKU9fKZf6OScf4oIgjzVaivmVAmYjy+ShpQEMc33dF9eVqKmMl/+JEaPx78sZY5qjXDngNBdKgN1G9Lm+vIJqaZ9ziRJAyFV4xE+Dja7k4p+3zLInkF94tH2xwClJWPCWlxNwNGzApfOPzqkjHvq8qKKlNd34BfmcJc9fn3I9x9wDqdlYNP6wDMe+wPhJwWZFo+Ym1hvEWRl8b/vvcjfkuDm+GbpQaU1kj3OFv83z0+VAq6MPWLqqffDzpI73KRodha/jhYfUQRjpZr9T+Cd9i0FBCdVnv/RpvAqT+Q/7tB4siUJhLJOFQE2dmVs9o1Vm3hjbAq5vJnzQW+NUMoyEgDjBErty+u+X+MM3y6wsBjPaqzJz2F7h3wK0Qby2Jjw9gRuPwHy9fPjrZtcLxV9EbXAkmzpLa1Wofde3UKkkwrJj+vuyTwo+lcUc5h8x+cfylicA2tcSRW0oTConchZlUa2d8zgzb1ZLSMx0LXcc3QnnutTP3m0mZSzDgDrvqUHPbh+WcEpeiNg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4835.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(136003)(376002)(39860400002)(5660300002)(6486002)(110136005)(16526019)(186003)(16576012)(316002)(8936002)(54906003)(8676002)(83380400001)(31686004)(36756003)(38100700002)(4326008)(2906002)(31696002)(86362001)(53546011)(26005)(478600001)(6666004)(66476007)(66946007)(956004)(2616005)(66556008)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?utf-8?B?RXI1SnFkS3I5YkhHeVFzQXdtT0c2M0pSY0xiS0pDNVRYOXNzU0JjN215L2E2?=
 =?utf-8?B?S0duWm1EMTIySDNGVXl2RE9wY05PNDN4ajE5anpHaTI5WDBNcmsyc3FTekl1?=
 =?utf-8?B?dDFXUVRJaXpTeGE3c2poeC8rNGtoRjJxM0paM3RRdzRteG8rRiszQjdzcGta?=
 =?utf-8?B?STlsNVRjTVRHSitmSnNyN3N3UGlVMGFuT29NNzJ4OWdnRXQxL3RjYXJTeS9U?=
 =?utf-8?B?RTZ4WTFacHJZTnRKNGlXSVh4NURPeDdZWldPNWVyMXp1MFA5MFhDVlNnSHVB?=
 =?utf-8?B?ZVlGeEJ0OTdna0dISlc5VFhKdVdaWU4wRmF0YVVBYTZ6ZEV1Y3hDNFlxc011?=
 =?utf-8?B?VlFIMjZsSzY4bVJ5RXprODJIRlR4Y1JaRzBxYXNxcGFXQjBWelF5bDBTL1pU?=
 =?utf-8?B?bFV4d2x1Rys4b1JXaGZHbjk2bVkzMEpLdnRJb201VXVGTW9BSS9SeS9FaFVi?=
 =?utf-8?B?bGJsQnh6S0VMeGhjUy9McXNOUEFUdVpsWm51bG9XQ0F3cFpHditPRCtyTjRw?=
 =?utf-8?B?R3g2bisxYWQ1ODA2WXlLcGMvZ0dZU1p6WEFEb2hnOC9sbW4rRmpJb1NrWW9l?=
 =?utf-8?B?Q1UxdnJTUnhQbGVsLzE3aWU2LzdJYUd3eWIxb1lkTndtb0F2OGhQaCtRRXFV?=
 =?utf-8?B?T2Vad2FMc2ZzZmVEbmFOWnUxekxkdjJoc0ZGOU1BNzdKQ2hJUTNiZXRBQWVo?=
 =?utf-8?B?di96Rks2enFGampieVRWU1RWcDRvNmpmVnJlMmwxYld5NS9STkc1OXBTbHZm?=
 =?utf-8?B?UXkvc0QwVDJVQkNyL25OdW9XVE9TOWU3czBEL3RhK1VSNTh0U2tTUFlBWUJU?=
 =?utf-8?B?VitONnBKclNYT1RpcXNqM1ZVUzI1OW9wbFRiVW82VkNFcFNycXhuQzBaZkJ6?=
 =?utf-8?B?ckVJcGtsRVpVdll2VUNJMmNQaGRTZ0gvRlEyZTNZUjRzVXRWeVdEVStsOVhF?=
 =?utf-8?B?WDNpNjVTVkM5YldHa05vR3g3dk9Wa2hxNGROelRyQmhiWXNYYkE5YXVvVXds?=
 =?utf-8?B?OENvMlp4VHFpY29RampvMnhFWEp1ZllIbk41MGlEVURibUNYWDVVVUZsZFJO?=
 =?utf-8?B?UjhDY1Q4TXpqS1prV1Vocm1qYzNmUGl0QWREVDU3eWVIQXp5Ylp2ckZLOWI5?=
 =?utf-8?B?blltYXZqL0ZsQUNOQ3BMaGdYMklNbXdodDBrbHVKV0VJbUZrZEtEek96NjBT?=
 =?utf-8?B?di9SSXVEQUNZc3VjRk5tWWJlVFpRU1RpeWtmbVlFQXFnMCtKMlJndG8wYU91?=
 =?utf-8?B?M21jZ2k1eFRmblA3dmNjS093b1JTWjRGTjlnMmt0NVFxOFRCTFo3ZVUyNlM2?=
 =?utf-8?B?VWRpMEludDUxVU5nOEhiZ09JbFN4U2l1Y1hYa0ZKOFpHUi9zVE8rRkZ4UmtI?=
 =?utf-8?B?WmxHZVRHT0NwM205ZU4yN1VWbTZnZEw3MldJamFYcG9LbC8wSDFTWWhvanlh?=
 =?utf-8?B?U25PdE0vWmpPRkNQWi9EMjBZUzFYY2g4TEJrQmdGejY1R29iSkNFd3FUSjFL?=
 =?utf-8?B?aEpuSjlBV2VsT2tsc1kyOEtRblh5RXgzMGZ0NXJuTGFwaS9FUDhuSWFMZ3ZT?=
 =?utf-8?B?V1I4b2wvUnRTYm5McmlVUVMrR1Y2clQxT1NNVkRGenYyMWdTcVV3QkZLYlRE?=
 =?utf-8?B?R082eHFBWlNyOVorRXZhLzNlMVZqWnprcG5jbmViT3lvN1lESlFHakE5Y3BG?=
 =?utf-8?B?QVJ0N3hEeUJCTFpEOTBRb0VyaU9Oc2ZHQkUwTGt0ODZyOUJYQ0kwZnZac3NZ?=
 =?utf-8?Q?W7dpCA685cZLHy/RC2X0LSNar7WzinJWDzvag8V?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0509ec4-6b8f-4367-58f4-08d91ab95e68
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 11:29:30.6019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YbRZHQFW8LrdPfcg0PHIfiRrdHkDnA91egH//LuM1xR07iWbHmJRDNGNnVDCe+qdHMyMit2Ndo4B3V/J5givBPQFz99ZL74UgX9sudjGmqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2770
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9988 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105190075
X-Proofpoint-ORIG-GUID: Z4Kazl6n80LHyEGY-Vt1bb5fGsLVQycm
X-Proofpoint-GUID: Z4Kazl6n80LHyEGY-Vt1bb5fGsLVQycm
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9988 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105190075
Message-ID-Hash: 56X3S3TFFSSFYUEMVP7XJBICIZGHMWE2
X-Message-ID-Hash: 56X3S3TFFSSFYUEMVP7XJBICIZGHMWE2
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/56X3S3TFFSSFYUEMVP7XJBICIZGHMWE2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCk9uIDUvMTgvMjEgODo1NiBQTSwgSmFuZSBDaHUgd3JvdGU6DQo+IE9uIDUvMTgvMjAyMSAx
MDoyNyBBTSwgSm9hbyBNYXJ0aW5zIHdyb3RlOg0KPiANCj4+IE9uIDUvNS8yMSAxMTozNiBQTSwg
Sm9hbyBNYXJ0aW5zIHdyb3RlOg0KPj4+IE9uIDUvNS8yMSAxMToyMCBQTSwgRGFuIFdpbGxpYW1z
IHdyb3RlOg0KPj4+PiBPbiBXZWQsIE1heSA1LCAyMDIxIGF0IDEyOjUwIFBNIEpvYW8gTWFydGlu
cyA8am9hby5tLm1hcnRpbnNAb3JhY2xlLmNvbT4gd3JvdGU6DQo+Pj4+PiBPbiA1LzUvMjEgNzo0
NCBQTSwgRGFuIFdpbGxpYW1zIHdyb3RlOg0KPj4+Pj4+IE9uIFRodSwgTWFyIDI1LCAyMDIxIGF0
IDQ6MTAgUE0gSm9hbyBNYXJ0aW5zIDxqb2FvLm0ubWFydGluc0BvcmFjbGUuY29tPiB3cm90ZToN
Cj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbWVtcmVtYXAuaCBiL2luY2x1ZGUv
bGludXgvbWVtcmVtYXAuaA0KPj4+Pj4+PiBpbmRleCBiNDZmNjNkY2FlZDMuLmJiMjhkODJkZGE1
ZSAxMDA2NDQNCj4+Pj4+Pj4gLS0tIGEvaW5jbHVkZS9saW51eC9tZW1yZW1hcC5oDQo+Pj4+Pj4+
ICsrKyBiL2luY2x1ZGUvbGludXgvbWVtcmVtYXAuaA0KPj4+Pj4+PiBAQCAtMTE0LDYgKzExNCw3
IEBAIHN0cnVjdCBkZXZfcGFnZW1hcCB7DQo+Pj4+Pj4+ICAgICAgICAgIHN0cnVjdCBjb21wbGV0
aW9uIGRvbmU7DQo+Pj4+Pj4+ICAgICAgICAgIGVudW0gbWVtb3J5X3R5cGUgdHlwZTsNCj4+Pj4+
Pj4gICAgICAgICAgdW5zaWduZWQgaW50IGZsYWdzOw0KPj4+Pj4+PiArICAgICAgIHVuc2lnbmVk
IGxvbmcgYWxpZ247DQo+Pj4+Pj4gSSB0aGluayB0aGlzIHdhbnRzIHNvbWUga2VybmVsLWRvYyBh
Ym92ZSB0byBpbmRpY2F0ZSB0aGF0IG5vbi16ZXJvDQo+Pj4+Pj4gbWVhbnMgInVzZSBjb21wb3Vu
ZCBwYWdlcyB3aXRoIHRhaWwtcGFnZSBkZWR1cCIgYW5kIHplcm8gLyBQQUdFX1NJWkUNCj4+Pj4+
PiBtZWFucyAidXNlIG5vbi1jb21wb3VuZCBiYXNlIHBhZ2VzIi4NCj4+IFsuLi5dDQo+Pg0KPj4+
Pj4+IFRoZSBub24temVybyB2YWx1ZSBtdXN0IGJlDQo+Pj4+Pj4gUEFHRV9TSVpFLCBQTURfUEFH
RV9TSVpFIG9yIFBVRF9QQUdFX1NJWkUuDQo+Pj4+Pj4gSG1tLCBtYXliZSBpdCBzaG91bGQgYmUg
YW4NCj4+Pj4+PiBlbnVtOg0KPj4+Pj4+DQo+Pj4+Pj4gZW51bSBkZXZtYXBfZ2VvbWV0cnkgew0K
Pj4+Pj4+ICAgICAgREVWTUFQX1BURSwNCj4+Pj4+PiAgICAgIERFVk1BUF9QTUQsDQo+Pj4+Pj4g
ICAgICBERVZNQVBfUFVELA0KPj4+Pj4+IH0NCj4+Pj4+Pg0KPj4+Pj4gSSBzdXBwb3NlIGEgY29u
dmVydGVyIGJldHdlZW4gZGV2bWFwX2dlb21ldHJ5IGFuZCBwYWdlX3NpemUgd291bGQgYmUgbmVl
ZGVkIHRvbz8gQW5kIG1heWJlDQo+Pj4+PiB0aGUgd2hvbGUgZGF4L252ZGltbSBhbGlnbiB2YWx1
ZXMgY2hhbmdlIG1lYW53aGlsZSAoYXMgYSBmb2xsb3d1cCBpbXByb3ZlbWVudCk/DQo+Pj4+IEkg
dGhpbmsgaXQgaXMgb2sgZm9yIGRheC9udmRpbW0gdG8gY29udGludWUgdG8gbWFpbnRhaW4gdGhl
aXIgYWxpZ24NCj4+Pj4gdmFsdWUgYmVjYXVzZSBpdCBzaG91bGQgYmUgb2sgdG8gaGF2ZSA0TUIg
YWxpZ24gaWYgdGhlIGRldmljZSByZWFsbHkNCj4+Pj4gd2FudGVkLiBIb3dldmVyLCB3aGVuIGl0
IGdvZXMgdG8gbWFwIHRoYXQgYWxpZ25tZW50IHdpdGgNCj4+Pj4gbWVtcmVtYXBfcGFnZXMoKSBp
dCBjYW4gcGljayBhIG1vZGUuIEZvciBleGFtcGxlLCBpdCdzIGFscmVhZHkgdGhlDQo+Pj4+IGNh
c2UgdGhhdCBkYXgtPmFsaWduID09IDFHQiBpcyBtYXBwZWQgd2l0aCBERVZNQVBfUFRFIHRvZGF5
LCBzbw0KPj4+PiB0aGV5J3JlIGFscmVhZHkgc2VwYXJhdGUgY29uY2VwdHMgdGhhdCBjYW4gc3Rh
eSBzZXBhcmF0ZS4NCj4+Pj4NCj4+PiBHb3RjaGEuDQo+PiBJIGFtIHJlY29uc2lkZXJpbmcgcGFy
dCBvZiB0aGUgYWJvdmUuIEluIGdlbmVyYWwsIHllcywgdGhlIG1lYW5pbmcgb2YgZGV2bWFwIEBh
bGlnbg0KPj4gcmVwcmVzZW50cyBhIHNsaWdodGx5IGRpZmZlcmVudCB2YXJpYXRpb24gb2YgdGhl
IGRldmljZSBAYWxpZ24gaS5lLiBob3cgdGhlIG1ldGFkYXRhIGlzDQo+PiBsYWlkIG91dCAqKmJ1
dCoqIHJlZ2FyZGxlc3Mgb2Ygd2hhdCBraW5kIG9mIHBhZ2UgdGFibGUgZW50cmllcyB3ZSB1c2Ug
dm1lbW1hcC4NCj4+DQo+PiBCeSB1c2luZyBERVZNQVBfUFRFL1BNRC9QVUQgd2UgbWlnaHQgZW5k
IHVwIDEpIGR1cGxpY2F0aW5nIHdoYXQgbnZkaW1tL2RheCBhbHJlYWR5DQo+PiB2YWxpZGF0ZXMg
aW4gdGVybXMgb2YgYWxsb3dlZCBkZXZpY2UgQGFsaWduIHZhbHVlcyAoaS5lLiBQQUdFX1NJWkUs
IFBNRF9TSVpFIGFuZCBQVURfU0laRSkNCj4+IDIpIHRoZSBnZW9tZXRyeSBvZiBtZXRhZGF0YSBp
cyB2ZXJ5IG11Y2ggdGllZCB0byB0aGUgdmFsdWUgd2UgcGljayB0byBAYWxpZ24gYXQgbmFtZXNw
YWNlDQo+PiBwcm92aXNpb25pbmcgLS0gbm90IHRoZSAiYWxpZ24iIHdlIG1pZ2h0IHVzZSBhdCBt
bWFwKCkgcGVyaGFwcyB0aGF0J3Mgd2hhdCB5b3UgcmVmZXJyZWQNCj4+IGFib3ZlPyAtLSBhbmQg
MykgdGhlIHZhbHVlIG9mIGdlb21ldHJ5IGFjdHVhbGx5IGRlcml2ZXMgZnJvbSBkYXggZGV2aWNl
IEBhbGlnbiBiZWNhdXNlIHdlDQo+PiB3aWxsIG5lZWQgdG8gY3JlYXRlIGNvbXBvdW5kIHBhZ2Vz
IHJlcHJlc2VudGluZyBhIHBhZ2Ugc2l6ZSBvZiBAYWxpZ24gdmFsdWUuDQo+Pg0KPj4gVXNpbmcg
eW91ciBleGFtcGxlIGFib3ZlOiB5b3UncmUgc2F5aW5nIHRoYXQgZGF4LT5hbGlnbiA9PSAxRyBp
cyBtYXBwZWQgd2l0aCBERVZNQVBfUFRFcywNCj4+IGluIHJlYWxpdHkgdGhlIHZtZW1tYXAgaXMg
cG9wdWxhdGVkIHdpdGggUE1Ecy9QVURzIHBhZ2UgdGFibGVzIChkZXBlbmRpbmcgb24gd2hhdCBh
cmNocw0KPj4gZGVjaWRlIHRvIGRvIGF0IHZtZW1tYXBfcG9wdWxhdGUoKSkgYW5kIHVzZXMgYmFz
ZSBwYWdlcyBhcyBpdHMgbWV0YWRhdGEgcmVnYXJkbGVzcyBvZiB3aGF0DQo+PiBkZXZpY2UgQGFs
aWduLiBJbiByZWFsaXR5IHdoYXQgd2Ugd2FudCB0byBjb252ZXkgaW4gQGdlb21ldHJ5IGlzIG5v
dCBwYWdlIHRhYmxlIHNpemVzLCBidXQNCj4+IGp1c3QgdGhlIHBhZ2Ugc2l6ZSB1c2VkIGZvciB0
aGUgdm1lbW1hcCBvZiB0aGUgZGF4IGRldmljZS4gQWRkaXRpb25hbGx5LCBsaW1pdGluZyBpdHMN
Cj4+IHZhbHVlIG1pZ2h0IG5vdCBiZSBkZXNpcmFibGUuLi4gaWYgdG9tb3Jyb3cgTGludXggZm9y
IHNvbWUgYXJjaCBzdXBwb3J0cyBkYXgvbnZkaW1tDQo+PiBkZXZpY2VzIHdpdGggNE0gYWxpZ24g
b3IgNjRLIGFsaWduLCB0aGUgdmFsdWUgb2YgQGdlb21ldHJ5IHdpbGwgaGF2ZSB0byByZWZsZWN0
IHRoZSA0TSB0bw0KPj4gY3JlYXRlIGNvbXBvdW5kIHBhZ2VzIG9mIG9yZGVyIDEwIGZvciB0aGUg
c2FpZCB2bWVtbWFwLg0KPj4NCj4+IEkgYW0gZ29pbmcgdG8gd2FpdCB1bnRpbCB5b3UgZmluaXNo
IHJldmlld2luZyB0aGUgcmVtYWluaW5nIGZvdXIgcGF0Y2hlcyBvZiB0aGlzIHNlcmllcywNCj4+
IGJ1dCBtYXliZSB0aGlzIGlzIGEgc2ltcGxlIG1pc25vbWVyIChzL2FsaWduL2dlb21ldHJ5Lykg
d2l0aCBhIGNvbW1lbnQgYnV0IHdpdGhvdXQNCj4+IERFVk1BUF97UFRFLFBNRCxQVUR9IGVudW0g
cGFydD8gT3IgcGVyaGFwcyBpdHMgb3duIHN0cnVjdCB3aXRoIGEgdmFsdWUgYW5kIGVudW0gYQ0K
Pj4gc2V0dGVyL2dldHRlciB0byBhdWRpdCBpdHMgdmFsdWU/IFRob3VnaHRzPw0KPiANCj4gR29v
ZCBwb2ludHMgdGhlcmUuDQo+IA0KPiBNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXTCoCBkYXgtPmFs
aWduwqAgY29udmV5cyBncmFudWxhcml0eSBvZiBzaXplIHdoaWxlIA0KPiBjYXJ2aW5nIG91dCBh
IG5hbWVzcGFjZSBpdCdzIGEgZ2VvbWV0cnkgYXR0cmlidXRlIGxvb3NlbHkgYWtpbiB0byBzZWN0
b3Igc2l6ZSBvZiBhIHNwaW5kbGUgDQo+IGRpc2suwqAgSSB0ZW5kIHRvIHRoaW5rIHRoYXQgZGV2
aWNlIHBhZ2VzaXplwqAgaGFzIGFsbW9zdCBubyByZWxhdGlvbiB0byAiYWxpZ24iIGluIHRoYXQs
IGl0J3MgDQo+IHBvc3NpYmxlIHRvIGhhdmUgMUcgImFsaWduIiBhbmQgNEsgcGFnZXNpemUsIG9y
IHZlcnNlIHZlcnNhLsKgIFRoYXQgaXMsIHdpdGggdGhlIGFkdmVudCBvZiBjb21wb3VuZCBwYWdl
IA0KPiBzdXBwb3J0LCBpdCBpcyBwb3NzaWJsZSB0byB0b3RhbGx5IHNlcGFyYXRlIHRoZSB0d28g
Y29uY2VwdHMuDQo+IA0KPiBIb3cgYWJvdXQgYWRkaW5nIGEgbmV3IG9wdGlvbiB0byAibmRjdGwg
Y3JlYXRlLW5hbWVzcGFjZSIgdGhhdCBkZXNjcmliZXMgDQo+IGRldmljZSBjcmVhdG9yJ3MgZGVz
aXJlZCBwYWdlc2l6ZSwgYW5kIGFub3RoZXIgcGFyYW1ldGVyIHRvIGRlc2NyaWJlIHdoZXRoZXIg
dGhlIHBhZ2VzaXplIHNoYWxsIA0KPiBiZSBmaXhlZCBvciBhbGxvd2VkIHRvIGJlIHNwbGl0IHVw
LCBzdWNoIHRoYXQsIGlmIHRoZSBpbnRlbnRpb24gaXMgdG8gbmV2ZXIgc3BsaXQgdXAgMk0gcGFn
ZXNpemUsIHRoZW4gaXQgDQo+IHdvdWxkIGJlIHBvc3NpYmxlIHRvIHNhdmUgYSBsb3QgbWV0YWRh
dGEgc3BhY2Ugb24gdGhlIGRldmljZT8NCg0KTWF5YmUgdGhhdCBjYW4gYmUgc2VsZWN0ZWQgYnkg
dGhlIGRyaXZlciB0b28sIGJ1dCBpdCdzIGFuIGludGVyZXN0aW5nIHBvaW50IHlvdSByYWlzZQ0K
c2hvdWxkIHdlIHNldHRsZSB3aXRoIHRoZSBnZW9tZXRyeSAoZS5nLiBsaWtlIGEgZ2VvbWV0cnkg
c3lzZnMgZW50cnkgSUlVQyB5b3VyDQpzdWdnZXN0aW9uPykuIGRldmljZS1kYXggZm9yIGV4YW1w
bGUgd291bGQgdXNlIGdlb21ldHJ5ID09IGFsaWduIGFuZCB0aGVyZWZvcmUgc2F2ZSBzcGFjZQ0K
KGxpa2Ugd2hhdCBJIHByb3Bvc2UgaW4gcGF0Y2ggMTApLiBCdXQgZnNkYXggd291bGQgcmV0YWlu
IHRoZSBkZWZhdWx0IHRoYXQgaXMgZ2VvbWV0cnkgPQ0KUEFHRV9TSVpFIGFuZCBhbGlnbiA9IFBN
RF9TSVpFIHNob3VsZCBpdCB3YW50IHRvIHNwbGl0IHBhZ2VzLg0KDQpJbnRlcmVzdGluZ2x5LCBk
ZXZtYXAgcG9pc29uaW5nIGFsd2F5cyBvY2N1ciBhdCBAYWxpZ24gbGV2ZWwgcmVnYXJkbGVzcyBv
ZiBAZ2VvbWV0cnkuDQoNCldoYXQgSSBhbSBub3Qgc3VyZSBpcyB3aGF0IHZhbHVlICh2cyBhZGRl
ZCBjb21wbGV4aXR5KSBpdCBicmluZ3MgdG8gYWxsb3cgZ2VvbWV0cnkgKnZhbHVlKg0KdG8gYmUg
c2VsZWN0ZWFibGUgYnkgdXNlciBnaXZlbiB0aGF0IHNvIGZhciB3ZSBzZWVtIHRvIG9ubHkgZXZl
ciBpbml0aWFsaXplIG1ldGFkYXRhIGFzDQplaXRoZXIgc2V0cyBvZiBiYXNlIHBhZ2VzIFsqXSBv
ciBzZXRzIG9mIGNvbXBvdW5kIHBhZ2VzIChvZiBhIHNpemUpLiBBbmQgdGhlIGRpZmZlcmVuY2UN
CmJldHdlZW4gYm90aCBjYW4gcG9zc2libHkgYmUgc3VtbWFyaXplZCB0byBzcGxpdC1hYmlsaXR5
IGxpa2UgeW91IHNheS4NCg0KWypdIHRoYXQgb3B0aW9uYWxseSBjYW4gYXJlIG1vcnBoZWQgaW50
byBjb21wb3VuZCBwYWdlcyBieSBkcml2ZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRp
bW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZk
aW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
