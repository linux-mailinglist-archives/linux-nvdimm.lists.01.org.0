Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 360923880D9
	for <lists+linux-nvdimm@lfdr.de>; Tue, 18 May 2021 21:57:01 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5DCD7100EBB9C;
	Tue, 18 May 2021 12:56:58 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=jane.chu@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6061F100EBB96
	for <linux-nvdimm@lists.01.org>; Tue, 18 May 2021 12:56:56 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14IJtC4d131430;
	Tue, 18 May 2021 19:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=YpP5KDooBKqUoSQ56XXIGj3kJ5YPbEQ4ASRJ5ac2DCc=;
 b=KWbrXa02kg+SlQcOSdB0JKnihIbIIiLVBbbn3nF9QbCWkRhDpj4mfBFQ1OoO7dbdmXq1
 9myR42+d8BISuUmQTy1JsRRP4t1Tx2UV/OVAbmN+q4S/6uN7qbzaw1j4IjFZi/CX+UJX
 8KaRWMi/PQ52NL828AjaxP6rpme8uc7ro/nSkXx8HeYDH4fvPVkpNluGAhCebGJWhnEg
 gWDbq2xZUyTyCWLfAGwd/cezea/Hl12hzToQjL0E2dtYRYyDVvNh3uKPL3QSRBqgW2Ga
 aR+XKX4VDv1gUtyeXC+J6I6J21ceDBHSURg0FCKuDvs/lSvmjkYjYMz4qr+HaB26F944 9Q==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2120.oracle.com with ESMTP id 38j6xnfg6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 May 2021 19:56:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14IJp3fx057573;
	Tue, 18 May 2021 19:56:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by aserp3030.oracle.com with ESMTP id 38meefhr78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 May 2021 19:56:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=io/Knn1cAMmPqtJpL959E5NTkSwwPH47FKw7O26pUt3VAWiaP1gpWnHBaJ8QlAswZsUgQtjrTCU1tejiDnbLOlH8J8av5NIRLGYQ32U+oGrwtXjhal3kCG/7PjZQQwYp+AHw4i/9mnwj7R7QoT/Xxyp0pepzCxitvkJPSugCe875anv6/7CVzX/WpCc8amO1lq7/RWmSixvkMIVFBBCnVOGgiqyWAsNxAos+UnydzBjHFB1FcnRE6Sfsb6wxDFZmc0Sj+1qR8ouIGW9v016jfdtOu/Y0VO4kbbT19FSk/GSMMUpt+dmBhE9nQycfscA6nH2Gk+z0rJ94cDPTYVFzoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpP5KDooBKqUoSQ56XXIGj3kJ5YPbEQ4ASRJ5ac2DCc=;
 b=NmHOvvt/1ZmQhVbyF671OBPYBMcuhAh5b0CnIwMe8yb55qZ3Kp6aq4ogY60l6Y4CMYcxs6/u2PviJWKXOI+iQLXefArNkWtWflsA8TELHMGceAkSL2PAAmBh88QYUr1Q/2Vfcdy91LQYi8MlFBZG+xIQDCgpLozboy/ur7941f8YdD0fWAK9R69XxZMruCPNMfkhCS99KC87eHynkSJ5QhdxqBI1DrkoJunjXT8lec+VMO6hRAOzesSW+c/FSazKY0RTKV++JsmdIQlFCmxhQaAabPJRMzB75CCRQK2pQkEeu/8rvpOhKVdG8De8K9DLVZI1pkfmNliM1l16gCAmxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpP5KDooBKqUoSQ56XXIGj3kJ5YPbEQ4ASRJ5ac2DCc=;
 b=I55pI0b7rwKG+xbpNnbHcXCKBVhV4x4CmCAsSeSECOLIkqJSvm4dqqIvQ2P7dt2sxvvaVSTrPZElpXTZuFsiRWpUCI+kfV/tKJdAi237zbmMIrUBeoHoTZeQV0btlhfRTnX4a6al6jyD6fo4x7tG3KlOSPoE/APi3VngIq3GH4s=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB3141.namprd10.prod.outlook.com (2603:10b6:a03:154::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Tue, 18 May
 2021 19:56:22 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::70b7:1647:6367:92f3]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::70b7:1647:6367:92f3%6]) with mapi id 15.20.4129.032; Tue, 18 May 2021
 19:56:22 +0000
Subject: Re: [PATCH v1 04/11] mm/memremap: add ZONE_DEVICE support for
 compound pages
To: Joao Martins <joao.m.martins@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <20210325230938.30752-1-joao.m.martins@oracle.com>
 <20210325230938.30752-5-joao.m.martins@oracle.com>
 <CAPcyv4gs_rHL7FPqyQEb3yT4jrv8Wo_xA2ojKsppoBfmDocq8A@mail.gmail.com>
 <cd1c9849-8660-dbdc-718a-aa4ba5d48c01@oracle.com>
 <CAPcyv4jG8+S6xJyp=1S2=dpit0Hs2+HgGwpWeRROCRuJnQYAxQ@mail.gmail.com>
 <56a3e271-4ef8-ba02-639e-fd7fe7de7e36@oracle.com>
 <8c922a58-c901-1ad9-5d19-1182bd6dea1e@oracle.com>
From: Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <a394d1a1-32e7-0ae2-a2a1-8ee431ecb479@oracle.com>
Date: Tue, 18 May 2021 12:56:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <8c922a58-c901-1ad9-5d19-1182bd6dea1e@oracle.com>
Content-Language: en-US
X-Originating-IP: [108.226.113.12]
X-ClientProxiedBy: SN1PR12CA0052.namprd12.prod.outlook.com
 (2603:10b6:802:20::23) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.70] (108.226.113.12) by SN1PR12CA0052.namprd12.prod.outlook.com (2603:10b6:802:20::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Tue, 18 May 2021 19:56:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d1d0f08-84be-4662-ac6e-08d91a370306
X-MS-TrafficTypeDiagnostic: BYAPR10MB3141:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BYAPR10MB314135B629586F7A2200B411F32C9@BYAPR10MB3141.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qoUgdyfvH9Rj5iETayj1jlAcsRTKlUHK7S1EUNow1pS8OlI34gBdJXeB+/tKxJje72DGzj1fJ1JWTWT74a4cgy71Y3u/a63qJ+B+ra+R+IYgX22XsMLI1hZ5Zt6m2FCLwLP0O7YJD7VquAGPpnhvjDadNG8C2KefOWs3WyuP0pD5vppShnHw6rtOzKOOoH8zR65QbOzOnsuoM5e94EmbCA7FvDwzvp1JxkS8+CCN23OI4Rz2EqfvPcCGQF1+ghvkquWMCErcG01Nf8LnJvIjDO3D43YimFYOjzW0KMWjv7uVZZr1qRXPihHLIxHoQhGv4Yh7gjk/0whMJke8uEQX8+Lw218NQanV/+yiKIaOgn4ziCEI0gi0HGNYI5+Rhd/5zQL84HGuSlsgrZGKwsOTwKmQqqooDLVkYMAa9EeznDlzP9vUjuYjnEv6KirIyvsBZsXwpQW/c9McQSYg4cZUzvSYf5WPy5Y5bASHTHsgYqDOD3/fgb+sMgbLf7D8Gg61X3xytzTJPuwccnrIbPCcfTIvGMNif+2IOVvMwpxGeoczxvw5QB5uyJy/sIV1TW1TMAtc/o7+Lh515r9JKa/Vvpjz0h2yxT+ThkGlW3Ugb26dBaqAkEPl5uflKvVFBtYZqHslGCsLKDBaRb1n+U1tGHFvhdE6hPvXY/1g9EJ4W6YiIDTb6oYiSPNebReyd+Bg
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(376002)(396003)(346002)(136003)(66476007)(66556008)(66946007)(31686004)(86362001)(53546011)(31696002)(36756003)(6486002)(8676002)(83380400001)(36916002)(8936002)(16576012)(2906002)(54906003)(110136005)(4326008)(316002)(6666004)(38100700002)(44832011)(186003)(478600001)(16526019)(26005)(5660300002)(956004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?utf-8?B?Y2pMZVAyRzlYbExHYVAxVVJjekgxSWx5RWxYMkljU0dEV2MzdS9pRFdKb0ov?=
 =?utf-8?B?WVJIN1ZZVHpmdHRhazhybFMvMXZyZkVaUDdZSG9WdHhhY2h5aG9VNU8wQTVH?=
 =?utf-8?B?UmJyMHE4U1NjUGJlSWxLWnJmeVdWUlVPNXZVUmsrb1VkN3ZYNVBrQjZQZXBI?=
 =?utf-8?B?aW91ajVJVHR2Z0pqallGS3JBVkY3U1Y2Q2k0NENlR0VmdEMxVXAxVWFKQXZs?=
 =?utf-8?B?dWh3MzhpTVlUYTNKcmZ1YWdHV2JiR1gzSURZZE4rVURlUzBDc2VsT0pVUVEy?=
 =?utf-8?B?NEFyV0J4S3IxZWRPL2pkWGI0RDlyV3JXYjR2Wk5BaUpNam5HSU5yZG4yU0ZR?=
 =?utf-8?B?SEE0NUU3eUNDR3lNZWVIWTdFVS9UNlRSSjJwcjRKaFBjcGxlb1NJa3dsTHE1?=
 =?utf-8?B?N0MxT0pGSzBFQnJkQi9hVVVXK1NpSExNY29VUWcybnJBOFVGekh0UE0xcEx1?=
 =?utf-8?B?OXBpc1VEbGZRQW5RSWhGdGFnay9DTjlpL1BzTGJ4L2xPeFNkNFo1Tk55d3hp?=
 =?utf-8?B?R3ZDcEVKVHdmUTBPUnd4NEhrVWpOU0RqR1NXL3pGdTlpcmRXejFhc0dTWVRC?=
 =?utf-8?B?THB6YXBlcVJsRE9CUVNMSjdoUy9VV1JoZEFxcFYrV3U2QmpUaWdBWktZZ1ZT?=
 =?utf-8?B?N09pR0l4dGtOb21reTA2SVBCSjhWZ25zelJId1BYay9PZzZ4Qzh1MlZaaE9a?=
 =?utf-8?B?V1Z3cndheXZVT1hGUDJBcDFYcUNCMWR5b3hKWit5TDZLMXhlQUZ2bCtDNktB?=
 =?utf-8?B?NWVwcVRqb1UrRFdMQjZHQTVORWhUVGJ5YS94SmU3a204TGFzcVUwTkZiZFhQ?=
 =?utf-8?B?OTBLa1kxMm44UVNCYklYa3lzZTk1VHNXREp2MmRNdTJ2UFROdjFtZTBsTmQ5?=
 =?utf-8?B?cWNnM3VnZTkveFo0a1lIajRhL2lTMmtQcjczeHBySXJEaXhvVDE2c0dYTDdH?=
 =?utf-8?B?Z1ZWdHhRb0tuWVNjbm9sa2FzZXB5RWFjRFErdmFPWTBqWjNRTTNNa2dERnQ5?=
 =?utf-8?B?NnZPSWkySmJnYm1xRGpxdFFuSE5WT2RuWnRrb2NBaTJyeU1pTzJGRUFFUVND?=
 =?utf-8?B?NmlxdzZnK1BjVW5CVDUzZzRxSHBERnlEUkZVY05xRTBQSTJpMU96ZGJTZ1Zv?=
 =?utf-8?B?UzR0WEE3RTg5RzFmaFRKYjRvMzdPbGNEUm5zSUhxZHRyZG5xVEI2czZXYi9v?=
 =?utf-8?B?dWJBaDB3eXRrbGpnT0FwM0Q3cVBHWFZYdkg2R094YjhKc3pSTE1ZMGhiUkky?=
 =?utf-8?B?VkNIZVZpK2tkZ3JSZUtXSHVlWlorN05ISi9sZ3JKdzhrdlU5ZVVPS3V3cjVC?=
 =?utf-8?B?VTJYUktacnJlY3FpVGZGL3ZHTVBvNXgyQ2t4UmZoUi9Ea3NEUTIzckFWWmdC?=
 =?utf-8?B?QllJdWhHMENNenhxVmNEdGkvSkplZ3lKK2I5YjUvSEtZbjNNTUMyTDVRSjdr?=
 =?utf-8?B?OTI2ZUpkYWVINEVpRHNMd2gwbEJwa2c4UHFtUk1tbTY0YVZFSndLbjNnbEgx?=
 =?utf-8?B?YWZ4d1JPRTN2SDRjMFR6Nk9vT3hYRmpXcUdPbmI5ME96MGMwNjk5NGR0Nnlk?=
 =?utf-8?B?NGxJNXNUcVNFeVpLdDM4SmhlcDlOZ0JDckpnWEQxQzRiV3JaNXBEZlJBRG9n?=
 =?utf-8?B?WlpYTGU2K3l1M2xKQ1k3TTRrMEJiVURyalVRVFpZK2JxRDZldzZKZ1FYSXZR?=
 =?utf-8?B?WlVCajlwV0FqbmlnaDRmOXNISUVXa1lQbVhzbG55N2NoNDNzUU51aE9XTlF2?=
 =?utf-8?Q?IIAw+3IWWg2c5yXg9buJoODv3qqx9/fukb697u7?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1d0f08-84be-4662-ac6e-08d91a370306
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 19:56:22.6605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KjtmwAuRjL8AUHb+cxuqCdJdOIFMm0ua78ZRcFKTVtGogx5RJchYBCDEOwOrCM90O/CVYstbbZ98ap7m2ila2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3141
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9988 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105180138
X-Proofpoint-GUID: CTslE_ws356odMu8ha1z3BcR8SWIXlCn
X-Proofpoint-ORIG-GUID: CTslE_ws356odMu8ha1z3BcR8SWIXlCn
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9988 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105180139
Message-ID-Hash: D2H2VKNUB3NLZXUUYBPSYVOMDLMPZQ7U
X-Message-ID-Hash: D2H2VKNUB3NLZXUUYBPSYVOMDLMPZQ7U
X-MailFrom: jane.chu@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/D2H2VKNUB3NLZXUUYBPSYVOMDLMPZQ7U/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

T24gNS8xOC8yMDIxIDEwOjI3IEFNLCBKb2FvIE1hcnRpbnMgd3JvdGU6DQoNCj4gT24gNS81LzIx
IDExOjM2IFBNLCBKb2FvIE1hcnRpbnMgd3JvdGU6DQo+PiBPbiA1LzUvMjEgMTE6MjAgUE0sIERh
biBXaWxsaWFtcyB3cm90ZToNCj4+PiBPbiBXZWQsIE1heSA1LCAyMDIxIGF0IDEyOjUwIFBNIEpv
YW8gTWFydGlucyA8am9hby5tLm1hcnRpbnNAb3JhY2xlLmNvbT4gd3JvdGU6DQo+Pj4+IE9uIDUv
NS8yMSA3OjQ0IFBNLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+Pj4+PiBPbiBUaHUsIE1hciAyNSwg
MjAyMSBhdCA0OjEwIFBNIEpvYW8gTWFydGlucyA8am9hby5tLm1hcnRpbnNAb3JhY2xlLmNvbT4g
d3JvdGU6DQo+Pj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbWVtcmVtYXAuaCBiL2lu
Y2x1ZGUvbGludXgvbWVtcmVtYXAuaA0KPj4+Pj4+IGluZGV4IGI0NmY2M2RjYWVkMy4uYmIyOGQ4
MmRkYTVlIDEwMDY0NA0KPj4+Pj4+IC0tLSBhL2luY2x1ZGUvbGludXgvbWVtcmVtYXAuaA0KPj4+
Pj4+ICsrKyBiL2luY2x1ZGUvbGludXgvbWVtcmVtYXAuaA0KPj4+Pj4+IEBAIC0xMTQsNiArMTE0
LDcgQEAgc3RydWN0IGRldl9wYWdlbWFwIHsNCj4+Pj4+PiAgICAgICAgICBzdHJ1Y3QgY29tcGxl
dGlvbiBkb25lOw0KPj4+Pj4+ICAgICAgICAgIGVudW0gbWVtb3J5X3R5cGUgdHlwZTsNCj4+Pj4+
PiAgICAgICAgICB1bnNpZ25lZCBpbnQgZmxhZ3M7DQo+Pj4+Pj4gKyAgICAgICB1bnNpZ25lZCBs
b25nIGFsaWduOw0KPj4+Pj4gSSB0aGluayB0aGlzIHdhbnRzIHNvbWUga2VybmVsLWRvYyBhYm92
ZSB0byBpbmRpY2F0ZSB0aGF0IG5vbi16ZXJvDQo+Pj4+PiBtZWFucyAidXNlIGNvbXBvdW5kIHBh
Z2VzIHdpdGggdGFpbC1wYWdlIGRlZHVwIiBhbmQgemVybyAvIFBBR0VfU0laRQ0KPj4+Pj4gbWVh
bnMgInVzZSBub24tY29tcG91bmQgYmFzZSBwYWdlcyIuDQo+IFsuLi5dDQo+DQo+Pj4+PiBUaGUg
bm9uLXplcm8gdmFsdWUgbXVzdCBiZQ0KPj4+Pj4gUEFHRV9TSVpFLCBQTURfUEFHRV9TSVpFIG9y
IFBVRF9QQUdFX1NJWkUuDQo+Pj4+PiBIbW0sIG1heWJlIGl0IHNob3VsZCBiZSBhbg0KPj4+Pj4g
ZW51bToNCj4+Pj4+DQo+Pj4+PiBlbnVtIGRldm1hcF9nZW9tZXRyeSB7DQo+Pj4+PiAgICAgIERF
Vk1BUF9QVEUsDQo+Pj4+PiAgICAgIERFVk1BUF9QTUQsDQo+Pj4+PiAgICAgIERFVk1BUF9QVUQs
DQo+Pj4+PiB9DQo+Pj4+Pg0KPj4+PiBJIHN1cHBvc2UgYSBjb252ZXJ0ZXIgYmV0d2VlbiBkZXZt
YXBfZ2VvbWV0cnkgYW5kIHBhZ2Vfc2l6ZSB3b3VsZCBiZSBuZWVkZWQgdG9vPyBBbmQgbWF5YmUN
Cj4+Pj4gdGhlIHdob2xlIGRheC9udmRpbW0gYWxpZ24gdmFsdWVzIGNoYW5nZSBtZWFud2hpbGUg
KGFzIGEgZm9sbG93dXAgaW1wcm92ZW1lbnQpPw0KPj4+IEkgdGhpbmsgaXQgaXMgb2sgZm9yIGRh
eC9udmRpbW0gdG8gY29udGludWUgdG8gbWFpbnRhaW4gdGhlaXIgYWxpZ24NCj4+PiB2YWx1ZSBi
ZWNhdXNlIGl0IHNob3VsZCBiZSBvayB0byBoYXZlIDRNQiBhbGlnbiBpZiB0aGUgZGV2aWNlIHJl
YWxseQ0KPj4+IHdhbnRlZC4gSG93ZXZlciwgd2hlbiBpdCBnb2VzIHRvIG1hcCB0aGF0IGFsaWdu
bWVudCB3aXRoDQo+Pj4gbWVtcmVtYXBfcGFnZXMoKSBpdCBjYW4gcGljayBhIG1vZGUuIEZvciBl
eGFtcGxlLCBpdCdzIGFscmVhZHkgdGhlDQo+Pj4gY2FzZSB0aGF0IGRheC0+YWxpZ24gPT0gMUdC
IGlzIG1hcHBlZCB3aXRoIERFVk1BUF9QVEUgdG9kYXksIHNvDQo+Pj4gdGhleSdyZSBhbHJlYWR5
IHNlcGFyYXRlIGNvbmNlcHRzIHRoYXQgY2FuIHN0YXkgc2VwYXJhdGUuDQo+Pj4NCj4+IEdvdGNo
YS4NCj4gSSBhbSByZWNvbnNpZGVyaW5nIHBhcnQgb2YgdGhlIGFib3ZlLiBJbiBnZW5lcmFsLCB5
ZXMsIHRoZSBtZWFuaW5nIG9mIGRldm1hcCBAYWxpZ24NCj4gcmVwcmVzZW50cyBhIHNsaWdodGx5
IGRpZmZlcmVudCB2YXJpYXRpb24gb2YgdGhlIGRldmljZSBAYWxpZ24gaS5lLiBob3cgdGhlIG1l
dGFkYXRhIGlzDQo+IGxhaWQgb3V0ICoqYnV0KiogcmVnYXJkbGVzcyBvZiB3aGF0IGtpbmQgb2Yg
cGFnZSB0YWJsZSBlbnRyaWVzIHdlIHVzZSB2bWVtbWFwLg0KPg0KPiBCeSB1c2luZyBERVZNQVBf
UFRFL1BNRC9QVUQgd2UgbWlnaHQgZW5kIHVwIDEpIGR1cGxpY2F0aW5nIHdoYXQgbnZkaW1tL2Rh
eCBhbHJlYWR5DQo+IHZhbGlkYXRlcyBpbiB0ZXJtcyBvZiBhbGxvd2VkIGRldmljZSBAYWxpZ24g
dmFsdWVzIChpLmUuIFBBR0VfU0laRSwgUE1EX1NJWkUgYW5kIFBVRF9TSVpFKQ0KPiAyKSB0aGUg
Z2VvbWV0cnkgb2YgbWV0YWRhdGEgaXMgdmVyeSBtdWNoIHRpZWQgdG8gdGhlIHZhbHVlIHdlIHBp
Y2sgdG8gQGFsaWduIGF0IG5hbWVzcGFjZQ0KPiBwcm92aXNpb25pbmcgLS0gbm90IHRoZSAiYWxp
Z24iIHdlIG1pZ2h0IHVzZSBhdCBtbWFwKCkgcGVyaGFwcyB0aGF0J3Mgd2hhdCB5b3UgcmVmZXJy
ZWQNCj4gYWJvdmU/IC0tIGFuZCAzKSB0aGUgdmFsdWUgb2YgZ2VvbWV0cnkgYWN0dWFsbHkgZGVy
aXZlcyBmcm9tIGRheCBkZXZpY2UgQGFsaWduIGJlY2F1c2Ugd2UNCj4gd2lsbCBuZWVkIHRvIGNy
ZWF0ZSBjb21wb3VuZCBwYWdlcyByZXByZXNlbnRpbmcgYSBwYWdlIHNpemUgb2YgQGFsaWduIHZh
bHVlLg0KPg0KPiBVc2luZyB5b3VyIGV4YW1wbGUgYWJvdmU6IHlvdSdyZSBzYXlpbmcgdGhhdCBk
YXgtPmFsaWduID09IDFHIGlzIG1hcHBlZCB3aXRoIERFVk1BUF9QVEVzLA0KPiBpbiByZWFsaXR5
IHRoZSB2bWVtbWFwIGlzIHBvcHVsYXRlZCB3aXRoIFBNRHMvUFVEcyBwYWdlIHRhYmxlcyAoZGVw
ZW5kaW5nIG9uIHdoYXQgYXJjaHMNCj4gZGVjaWRlIHRvIGRvIGF0IHZtZW1tYXBfcG9wdWxhdGUo
KSkgYW5kIHVzZXMgYmFzZSBwYWdlcyBhcyBpdHMgbWV0YWRhdGEgcmVnYXJkbGVzcyBvZiB3aGF0
DQo+IGRldmljZSBAYWxpZ24uIEluIHJlYWxpdHkgd2hhdCB3ZSB3YW50IHRvIGNvbnZleSBpbiBA
Z2VvbWV0cnkgaXMgbm90IHBhZ2UgdGFibGUgc2l6ZXMsIGJ1dA0KPiBqdXN0IHRoZSBwYWdlIHNp
emUgdXNlZCBmb3IgdGhlIHZtZW1tYXAgb2YgdGhlIGRheCBkZXZpY2UuIEFkZGl0aW9uYWxseSwg
bGltaXRpbmcgaXRzDQo+IHZhbHVlIG1pZ2h0IG5vdCBiZSBkZXNpcmFibGUuLi4gaWYgdG9tb3Jy
b3cgTGludXggZm9yIHNvbWUgYXJjaCBzdXBwb3J0cyBkYXgvbnZkaW1tDQo+IGRldmljZXMgd2l0
aCA0TSBhbGlnbiBvciA2NEsgYWxpZ24sIHRoZSB2YWx1ZSBvZiBAZ2VvbWV0cnkgd2lsbCBoYXZl
IHRvIHJlZmxlY3QgdGhlIDRNIHRvDQo+IGNyZWF0ZSBjb21wb3VuZCBwYWdlcyBvZiBvcmRlciAx
MCBmb3IgdGhlIHNhaWQgdm1lbW1hcC4NCj4NCj4gSSBhbSBnb2luZyB0byB3YWl0IHVudGlsIHlv
dSBmaW5pc2ggcmV2aWV3aW5nIHRoZSByZW1haW5pbmcgZm91ciBwYXRjaGVzIG9mIHRoaXMgc2Vy
aWVzLA0KPiBidXQgbWF5YmUgdGhpcyBpcyBhIHNpbXBsZSBtaXNub21lciAocy9hbGlnbi9nZW9t
ZXRyeS8pIHdpdGggYSBjb21tZW50IGJ1dCB3aXRob3V0DQo+IERFVk1BUF97UFRFLFBNRCxQVUR9
IGVudW0gcGFydD8gT3IgcGVyaGFwcyBpdHMgb3duIHN0cnVjdCB3aXRoIGEgdmFsdWUgYW5kIGVu
dW0gYQ0KPiBzZXR0ZXIvZ2V0dGVyIHRvIGF1ZGl0IGl0cyB2YWx1ZT8gVGhvdWdodHM/DQo+DQo+
IAkJSm9hbw0KDQpHb29kIHBvaW50cyB0aGVyZS4NCg0KTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0
wqAgZGF4LT5hbGlnbsKgIGNvbnZleXMgZ3JhbnVsYXJpdHkgb2Ygc2l6ZSB3aGlsZSANCmNhcnZp
bmcgb3V0IGEgbmFtZXNwYWNlLA0KDQppdCdzIGEgZ2VvbWV0cnkgYXR0cmlidXRlIGxvb3NlbHkg
YWtpbiB0byBzZWN0b3Igc2l6ZSBvZiBhIHNwaW5kbGUgDQpkaXNrLsKgIEkgdGVuZCB0byB0aGlu
ayB0aGF0DQoNCmRldmljZSBwYWdlc2l6ZcKgIGhhcyBhbG1vc3Qgbm8gcmVsYXRpb24gdG8gImFs
aWduIiBpbiB0aGF0LCBpdCdzIA0KcG9zc2libGUgdG8gaGF2ZSAxRyAiYWxpZ24iIGFuZA0KDQo0
SyBwYWdlc2l6ZSwgb3IgdmVyc2UgdmVyc2EuwqAgVGhhdCBpcywgd2l0aCB0aGUgYWR2ZW50IG9m
IGNvbXBvdW5kIHBhZ2UgDQpzdXBwb3J0LCBpdCBpcyBwb3NzaWJsZQ0KDQp0byB0b3RhbGx5IHNl
cGFyYXRlIHRoZSB0d28gY29uY2VwdHMuDQoNCkhvdyBhYm91dCBhZGRpbmcgYSBuZXcgb3B0aW9u
IHRvICJuZGN0bCBjcmVhdGUtbmFtZXNwYWNlIiB0aGF0IGRlc2NyaWJlcyANCmRldmljZSBjcmVh
dG9yJ3MgZGVzaXJlZA0KDQpwYWdlc2l6ZSwgYW5kIGFub3RoZXIgcGFyYW1ldGVyIHRvIGRlc2Ny
aWJlIHdoZXRoZXIgdGhlIHBhZ2VzaXplIHNoYWxsIA0KYmUgZml4ZWQgb3IgYWxsb3dlZCB0byBi
ZSBzcGxpdCB1cCwNCg0Kc3VjaCB0aGF0LCBpZiB0aGUgaW50ZW50aW9uIGlzIHRvIG5ldmVyIHNw
bGl0IHVwIDJNIHBhZ2VzaXplLCB0aGVuIGl0IA0Kd291bGQgYmUgcG9zc2libGUgdG8gc2F2ZSBh
IGxvdCBtZXRhZGF0YQ0KDQpzcGFjZSBvbiB0aGUgZGV2aWNlPw0KDQp0aGFua3MsDQoNCi1qYW5l
DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1u
dmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJz
Y3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
