Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E60207DC8
	for <lists+linux-nvdimm@lfdr.de>; Wed, 24 Jun 2020 22:57:49 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EA31E10FCBC5C;
	Wed, 24 Jun 2020 13:57:47 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=jane.chu@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 47E9510FC72A4
	for <linux-nvdimm@lists.01.org>; Wed, 24 Jun 2020 13:57:45 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05OKpunX185741;
	Wed, 24 Jun 2020 20:57:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ty3w8xpTnMPzIpUtbRqIPAJ/vjriMvgnVtCYrWWp+Nw=;
 b=bjqrym/ooenwrzyTjXESct92fVOKuaUBNskCLklrc99NYwiaNvsNLg4Lbw/IFmvxQaGe
 pse19I9W+rRq54B4mcw2SFOuzJPl5Y1nT9P9Kuo7S2mdR2R6QSgiQvEQq7N1lSaRMfft
 pBneuAnd32pGRMQGGVSD5R9eHrZAdn0GClzHoE/lRaLpW6KOiuAVJ5uZk6LGu6fEwlOm
 nfsF7Lib67vNbajgwo+X8ykrRVUcrDPrtwrbvJ+bdFK7FWOo5B+wDItyW1g7LOJBxhAc
 KNn94p9bQWwAIm4m9UgBGxSteYOy4aiFo0TyFMf8hNRudKQMYCAVwNUgXZk9h4nKFtqr gQ==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2120.oracle.com with ESMTP id 31uustn581-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Jun 2020 20:57:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05OKsABf090852;
	Wed, 24 Jun 2020 20:57:23 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserp3020.oracle.com with ESMTP id 31uur7apw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2020 20:57:23 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05OKvJV4029857;
	Wed, 24 Jun 2020 20:57:20 GMT
Received: from [10.159.255.168] (/10.159.255.168)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 24 Jun 2020 20:57:19 +0000
Subject: Re: [RFC] Make the memory failure blast radius more precise
To: David Rientjes <rientjes@google.com>, "Luck, Tony" <tony.luck@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Peter Xu
 <peterx@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>
References: <20200623201745.GG21350@casper.infradead.org>
 <20200623220412.GA21232@agluck-desk2.amr.corp.intel.com>
 <alpine.DEB.2.22.394.2006232114100.97817@chino.kir.corp.google.com>
From: Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <19ffec14-28c7-fddc-3042-6ccb8d4e83fa@oracle.com>
Date: Wed, 24 Jun 2020 13:57:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2006232114100.97817@chino.kir.corp.google.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9662 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006240135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9662 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 cotscore=-2147483648 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1011
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006240135
Message-ID-Hash: SSYAZR3JEVJD4HRIJJGBIOFNO7PSWU6Q
X-Message-ID-Hash: SSYAZR3JEVJD4HRIJJGBIOFNO7PSWU6Q
X-MailFrom: jane.chu@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Matthew Wilcox <willy@infradead.org>, Borislav Petkov <bp@alien8.de>, Naoya Horiguchi <naoya.horiguchi@nec.com>, linux-edac@vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, "Darrick J. Wong" <darrick.wong@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SSYAZR3JEVJD4HRIJJGBIOFNO7PSWU6Q/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

Hi, David,

On 6/23/2020 9:32 PM, David Rientjes wrote:
> I don't want to hijack Matthew's thread which is primarily about DAX, but
> did get intrigued by your concerns about hugetlbfs page poisoning.  We can
> fork the thread off here to discuss only the hugetlb application of this
> if it makes sense to you or you'd like to collaborate on it as well.

hugetlbfs is not supported in DAX, are you planning to add support?

thanks,
-jane
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
