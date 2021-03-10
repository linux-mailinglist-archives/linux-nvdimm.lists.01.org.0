Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C90334658
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Mar 2021 19:13:24 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 49CF3100F2242;
	Wed, 10 Mar 2021 10:13:22 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 852C6100EC1EB
	for <linux-nvdimm@lists.01.org>; Wed, 10 Mar 2021 10:13:19 -0800 (PST)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12AHtHXL113070;
	Wed, 10 Mar 2021 18:12:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=VE5uZerFYMy4LtejKG5eXgbfeFMInl6YBKKjwyzzbQ4=;
 b=MtF5uCAtku+3JjX4XiG08NTaGpzBxsF+pHnZyWRpk8citO6T8TriIKIMTdJzKjlBc6Yz
 M02dZGyY3Xb4p8TjEJdML5djaYiRdPD0kjUybmSKnYLlcV2KgZXd26SQq9t7y47raetB
 DL5z9J/A+wG8/Q5aS31tP/TIuvSPK9v5W5FjOs363KeKKiGopptcVy9zCKgmSw/cM3yt
 UEKjd9u5ETFfe8JNMxWX9Hu/qu/o57waJ24/0dWGE9cvdhGA+nfaKNNPIuRTBrmgG4ev
 tV03/jOZKUKhcUVwC6ZCoPWmbw7EXBVCiR+NKAanr3KOUjVTlOeCQrEFyQZU06hkcTjq vA==
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by userp2120.oracle.com with ESMTP id 3742cnbwe9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Mar 2021 18:12:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12AHtWi6152567;
	Wed, 10 Mar 2021 18:12:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	by userp3030.oracle.com with ESMTP id 374knyrnvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Mar 2021 18:12:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLVvR2XDHFQoIfX2mvS9CQ4Z6WarBmBa00d8ofjJYNGXJbRcr0eI1pN/T2IjoCtjlwGiY0qL8NK7kAZ7fxdXctPO+ssOTEXiSH8KfiOyMJwyR3UHwWno19e5h0Alh96UYwYGvdaJtWxKhi42xlnXikBPsY6vA5hgoZobreC2JElKr6nAOieGH7+79b4Q/wO8udXY9VH5DBJd25sp4m3M+w03yQC6LT3SgnmehUVDLju31qNFrhk+RcZ6A27uA6JJ/nXVpxv8PBZhEiYiNY0GNDgwk9Pl4bjsfVcoZC2MFEDjuwNxDp4LkgTZ6VQOaDp0P4Iqo8Md9PSwqPMrwqofVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VE5uZerFYMy4LtejKG5eXgbfeFMInl6YBKKjwyzzbQ4=;
 b=L3uupi3cB4uXjOxPpNA+v9uzuqetM7ml9M0R9RNCI5osxhKpnfUSq1m6epZc87WL5qJuWNQMsXN+PdF6B2Oq0CKT1d33kd5TYVoO5lk/gopQssZZEc+K9n99CyusOoQPLVNYcgCUYV8PDz+0KCX8bPIJf/Ky0QjGpiPAmN9P68T0ONg+1jPVHDOjTt6zpt5sY3AsWyts2uGpW1rY/0mNWxfaTK9QPLn7dq4ZY6aZGAu1vRi/cES0Gqip1ECOtuFRboq6kGCre8xsdLmpIz1RzQ64HqP/hm+aSRYoCpJg4rAH+2g0A+b3ufzm84+KFL/SNEYDtBtQ1xCn7LJ7BA21bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VE5uZerFYMy4LtejKG5eXgbfeFMInl6YBKKjwyzzbQ4=;
 b=ji4Nnj821X30009dW5rSUoQY1Zdx6Z+S58LWIZt4mbOuFrXVDaVVRioqDwREeQvScLIiJdGKhsPq6E9lC7BwCg5g+9ETn99k4kJ7QfONqfs53itS6zZlJ7g45m6ripAKBVzIUeQxeHEgclfp3V5b+wO8vaSXtKHowXmEE+3kqpw=
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BYAPR10MB2743.namprd10.prod.outlook.com (2603:10b6:a02:ad::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.30; Wed, 10 Mar
 2021 18:12:55 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3912.029; Wed, 10 Mar 2021
 18:12:55 +0000
From: Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH RFC 1/9] memremap: add ZONE_DEVICE support for compound
 pages
To: Dan Williams <dan.j.williams@intel.com>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <20201208172901.17384-2-joao.m.martins@oracle.com>
 <7249cfd2-c178-2e6a-6b03-307a05f11785@nvidia.com>
 <CAPcyv4iMzaAqKe6C1Q_feHL5SwppPdBem0i6XfYX4sL1U6sHgg@mail.gmail.com>
 <7e8908ca-4d0f-6549-0442-d4b15fbc90ab@oracle.com>
 <CAPcyv4jDk=ppsR2Pvgpb1DqWk5D8bkrNCAtyRU21ShnC3fzdSA@mail.gmail.com>
Message-ID: <b1ef0aa7-754c-78e8-ffbd-87397c1eaf79@oracle.com>
Date: Wed, 10 Mar 2021 18:12:47 +0000
In-Reply-To: <CAPcyv4jDk=ppsR2Pvgpb1DqWk5D8bkrNCAtyRU21ShnC3fzdSA@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: AM0PR04CA0133.eurprd04.prod.outlook.com
 (2603:10a6:208:55::38) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.67] (94.61.1.144) by AM0PR04CA0133.eurprd04.prod.outlook.com (2603:10a6:208:55::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 10 Mar 2021 18:12:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b945d64-353e-4826-a25b-08d8e3f0206c
X-MS-TrafficTypeDiagnostic: BYAPR10MB2743:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BYAPR10MB2743EB0E8378C30088D3DB04BB919@BYAPR10MB2743.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0LdE7WdbXS+PpHSA3YPzYWCJN543miL1/VG/b4nPoq5LxLSQQeAaOJ6HGWeXGGVp8MJQAH84gy748k4+cO13iEt00E1BmarchIs9untRKvtXunphvAQ0woTTA258f9Zb4crXahQhLk5gA0D20KznzlbM7GPQU2T3bJEd2x06q38KX9ZqcAFEy8PGrhEMBB1Ap7I2zQ6JmIj/Li2lDEdwHJ3i1IgN34Q+L1hdbc63XSbVpujvd5qqpg4XlRH9sWF3YckdV6OQt/hvCexCZ+IJRIX8QiU/brR/mq7HG16xzB3XlrfxOabP+chFz6f36al6p9xRgRQ2Dtofe4VUo1dIf7KQjE8eI9OElc1ktJb49vDUbJuFqLwisQCmjTdIMlLqTxKk9YmxwC3PtChrTPnSGsUZhuqwq6FVYuocEtDCKl6fvgKDaYr0r9Hv08klmU2qzooAzCnb4QZUIANyTPfS+5O4zjXPZZ9IUbTAVarEjI+0kRrmbW5H//q8ThG/klN9B1RBH8q2NtNtjL6lmnpxJvtG+86p0W6yTIRNYvt0s1sSIrXDFlExospigSxG4GdJ2n1sH4o9eaWkDAa6D+t5KQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(39860400002)(396003)(346002)(4326008)(5660300002)(2906002)(54906003)(83380400001)(316002)(16576012)(53546011)(6916009)(956004)(2616005)(86362001)(36756003)(31686004)(16526019)(66946007)(6666004)(66556008)(478600001)(186003)(26005)(8936002)(6486002)(31696002)(8676002)(66476007)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?utf-8?B?WUJtL3BOWnFrN3IrcGZUd3BSUmo2dllUNU5NQTQvY2d5KzBqZ0xia3BFcmVw?=
 =?utf-8?B?blE3R0lpdi85M2VwcUp6dDlETHdpVTBZR0VGaE0xUVVha3dZSjZzQTIxZ1FQ?=
 =?utf-8?B?OXhid0Q2U2QyREhBVGhMaHlHQUp6UlJGMVpPUVVOZlJkNWFka2NlNXFNYUYx?=
 =?utf-8?B?dGYyV3Q0WWFQaXo2dm82aFpVS1B4bEtNcVlMUDZwN0g3WVB1bXhMQnhsVGVz?=
 =?utf-8?B?Yk8yakVUZXpkZkpnY0FGQ1lMaTdmc2xlWVJqRFZLVm9hdFd0TkRqTTZVbjNI?=
 =?utf-8?B?L21xVGlWS0x5bnEyN0dvc2pPVEMrKzJZaVhWTGNOakFnU0NqNVkyMmZ6clo1?=
 =?utf-8?B?bkNpdGRFK2FFZVBkbU9ZU3Z5Rm9KWkFLYzQrMVFMc1lzMTlrR2taSXNuY0ZB?=
 =?utf-8?B?YTZWaDMzbExHakhFc21BeWMzK3dURVFmUWxFWTcvcDlkNmV2TjFVYXdUMjBn?=
 =?utf-8?B?c3lPZFg1b1lnUGlWM1NTNHIxb1JCQ3VYN3prNitzTjdKVWgvNFdhL1ZCZEJF?=
 =?utf-8?B?RWJhM0lOdXpiOG9mRTJ5MVg0bUx2T2g2SWZxd09NVjdxN2ZmSkN6NEFXVW9m?=
 =?utf-8?B?TDNweENxUllLSDhYQUoxYm02YVlRbmRxendIZFZSQkxzdytOTGFLdXR6SzZt?=
 =?utf-8?B?NlhQL3ZoQWZaamhSQmpIa0g1Nmw5QlNheS92dVQ3TDNOblVtd1FBVTYwN0t1?=
 =?utf-8?B?cW1yNGM0d0ZoTU9WWVRiaXcwT2FYSnE2QXppSlZreFlFbGdCa3Zvbjh1WTRP?=
 =?utf-8?B?OW9TN3ZZVjVtK0FUMVBNNEdIYlBiTWJ1K0svcWZtNysyMUJad3MzZlcxb1l2?=
 =?utf-8?B?b2JPbWI4Qzd6cHNwTGJ1c1JsMXNPQ2czbzJsWXRuTTk4K0RvekdiT3FYekFr?=
 =?utf-8?B?QkRwdjJLK1NOL0VjTEx3Z1VYUG03YS96SUc2bm1BTmZYVHZVa05kL1E2bWZR?=
 =?utf-8?B?L1AxamJUTy9pbGdzSkFqWU0yWmMvbFlGeUhnU0I2eVdqTklCTWcySlVSaUZS?=
 =?utf-8?B?bm1sVGtXMkRialN1R0VPclZkK2V2NFAvVkJHRHorMFhJNit2T0pTdFV0NzJv?=
 =?utf-8?B?MmRIOXVpeWkrYkZvYlp6WGNiZ3cyQllDZHRuVGk1S3FXWk52N3Btc1U0ZFFm?=
 =?utf-8?B?eFg3NGtiUi9iQWpGRll5MEpQMk91bGlGUVg4aXIxell6cS9DK2JRaFlDQVd6?=
 =?utf-8?B?YndEZWlWWnlNNld1Wk1MVHVjZ09DVGxlaGdzUVQzSXFibG1LMVNwV2krazBj?=
 =?utf-8?B?dUI3RmVrNUpnajBMZDA4d2YwT3JLdU5oZVEvdzZFbGo0MUZuVjRhd3BmNVRn?=
 =?utf-8?B?L044VmF5d3dEb2lRckdRSUpmTUF2NWY3Zk50NG5CMmIxRlJnZjNWbktMZXQ0?=
 =?utf-8?B?TUg2ZUpWYnl4WWtsWjhvMFgwVk1YVzUwT0M0SCtIOTVuTkdxMHVnN0Q3UGxR?=
 =?utf-8?B?U1pQNUdBNzY3dEc2L2czekQvQ2o1alFzUk1SSXluSUo5UEVKN21kSmZYb05z?=
 =?utf-8?B?SGhjWkQ4aWQvengzUkhlLzZiYTlNMFBaNkpQaUhBRmV3Y0VDWjBNdGlLbjVD?=
 =?utf-8?B?SEZ0d2lUVFJ4eXRjN1Nib24vZ0Y4RHZnVmJMWm9rbTNTYzZVQk5BK2M3cCto?=
 =?utf-8?B?UElVVFFhTzFXSzJ1L3ZXdmNnWFhRVVMrdFpUaWsrYTJyMEVzNHVyaWpyM083?=
 =?utf-8?B?bW5qMHBTcTI0YTZDamJVOUkwdjgzUGxKVU9XUmswNDlFTzdiRmZ1bkd1N0JN?=
 =?utf-8?Q?WTcROGn1Rv/NDKiSbBf1gJVzvZKDK5kcUswUv5T?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b945d64-353e-4826-a25b-08d8e3f0206c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 18:12:55.1060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FVBSJDWZwym2QM9a6jkJI8gnnP+FHKAyHMT1MBnLIUd3rqTtW5sVWNCaNYyDnut+XJAE2LE/FDABDR40xmfoH0YukzFgZTiyHlN2zSc9CPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2743
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9919 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103100087
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9919 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103100087
Message-ID-Hash: A3AEAWCPSMPTAQGDFETHIWJBOMF4LCFM
X-Message-ID-Hash: A3AEAWCPSMPTAQGDFETHIWJBOMF4LCFM
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/A3AEAWCPSMPTAQGDFETHIWJBOMF4LCFM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2/22/21 8:37 PM, Dan Williams wrote:
> On Mon, Feb 22, 2021 at 3:24 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>> On 2/20/21 1:43 AM, Dan Williams wrote:
>>> On Tue, Dec 8, 2020 at 9:59 PM John Hubbard <jhubbard@nvidia.com> wrote:
>>>> On 12/8/20 9:28 AM, Joao Martins wrote:
>> One thing to point out about altmap is that the degradation (in pinning and
>> unpining) we observed with struct page's in device memory, is no longer observed
>> once 1) we batch ref count updates as we move to compound pages 2) reusing
>> tail pages seems to lead to these struct pages staying more likely in cache
>> which perhaps contributes to dirtying a lot less cachelines.
> 
> True, it makes it more palatable to survive 'struct page' in PMEM, 

I want to retract for now what I said above wrt to the no degradation with
struct page in device comment. I was fooled by a bug on a patch later down
this series. Particular because I accidentally cleared PGMAP_ALTMAP_VALID when
unilaterally setting PGMAP_COMPOUND, which consequently lead to always
allocating struct pages from memory. No wonder the numbers were just as fast.
I am still confident that it's going to be faster and observe less degradation
in pinning/init. Init for now is worst-case 2x faster. But to be *as fast* struct
pages in memory might still be early to say.

The broken masking of the PGMAP_ALTMAP_VALID bit did hide one flaw, where
we don't support altmap for basepages on x86/mm and it apparently depends
on architectures to implement it (and a couple other issues). The vmemmap
allocation isn't the problem, so the previous comment in this thread that
altmap doesn't change much in the vmemmap_populate_compound_pages() is
still accurate.

The problem though resides on the freeing of vmemmap pagetables with
basepages *with altmap* (e.g. at dax-device teardown) which require arch
support. Doing it properly would mean making the altmap reserve smaller
(given fewer pages are allocated), and the ability for the altmap pfn
allocator to track references per pfn. But I think it deserves its own
separate patch series (probably almost just as big).

Perhaps for this set I can stick without altmap as you suggested, and
use hugepage vmemmap population (which wouldn't
lead to device memory savings) instead of reusing base pages . I would
still leave the compound page support logic as metadata representation
for > 4K @align, as I think that's the right thing to do. And then
a separate series onto improving altmap to leverage the metadata reduction
support as done with non-device struct pages.

Thoughts?

	Joao
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
