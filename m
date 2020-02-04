Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE78151E14
	for <lists+linux-nvdimm@lfdr.de>; Tue,  4 Feb 2020 17:18:40 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3A81D10FC3397;
	Tue,  4 Feb 2020 08:21:56 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A9C8010FC3395
	for <linux-nvdimm@lists.01.org>; Tue,  4 Feb 2020 08:21:54 -0800 (PST)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 014GFpm9099115;
	Tue, 4 Feb 2020 16:18:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=rKE6BXas3LZe481kZHsQO9RrFsrswJ8xXmcNA5ia/sc=;
 b=B83REeVYK/qA/uk+oNSDRp+5EZio8ECEraJSWV7MzTlwxzLxjK0dCBX7/3cBu4IuEntU
 Q1Y8pi4wWrh1em0ZC4e7lGaKm6i/0RRM/QnIwHH1gDJLvate0O6i76HWnDscTBFE03jp
 m0vYMX+CR8CzHfsUkd0oSvHE3E4LMihs90G5z8RF7RlKSMXGVYHAiLAbIu9zS8fO5cqp
 BmX2YTRDlSo03ouhjqzQh0eaz+YLA705/vTz5f67vJro2hoMppguLlZtpfjRoh/Ajtlw
 q5v78rojwBeLB9TacrjrNMjrioqHLiAuhvXudutZGto/SNje390kzS8o5T8HTQ+QrK+h FQ==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2130.oracle.com with ESMTP id 2xw0ru7rry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2020 16:18:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 014GGNC4155573;
	Tue, 4 Feb 2020 16:18:09 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by aserp3030.oracle.com with ESMTP id 2xxw0xb6a8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2020 16:18:08 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 014GI6qi018533;
	Tue, 4 Feb 2020 16:18:06 GMT
Received: from [10.175.207.61] (/10.175.207.61)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 04 Feb 2020 08:18:05 -0800
Subject: Re: [PATCH RFC 02/10] mm: Handle pmd entries in follow_pfn()
To: Matthew Wilcox <willy@infradead.org>
References: <20200110190313.17144-1-joao.m.martins@oracle.com>
 <20200110190313.17144-3-joao.m.martins@oracle.com>
 <20200203213718.GL8731@bombadil.infradead.org>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <94c35449-16ac-235b-fa2e-a5aea85dc568@oracle.com>
Date: Tue, 4 Feb 2020 16:17:59 +0000
MIME-Version: 1.0
In-Reply-To: <20200203213718.GL8731@bombadil.infradead.org>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=767
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002040108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=830 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002040108
Message-ID-Hash: ZGWO53AZ47TDKH5BB3AY5P62Z5NXPRZN
X-Message-ID-Hash: ZGWO53AZ47TDKH5BB3AY5P62Z5NXPRZN
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Liran Alon <liran.alon@oracle.com>, Nikita Leshenko <nikita.leshchenko@oracle.com>, Barret Rhoden <brho@google.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZGWO53AZ47TDKH5BB3AY5P62Z5NXPRZN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2/3/20 9:37 PM, Matthew Wilcox wrote:
> On Fri, Jan 10, 2020 at 07:03:05PM +0000, Joao Martins wrote:
>> @@ -4366,6 +4366,7 @@ EXPORT_SYMBOL(follow_pte_pmd);
>>  int follow_pfn(struct vm_area_struct *vma, unsigned long address,
>>  	unsigned long *pfn)
>>  {
>> +	pmd_t *pmdpp = NULL;
> 
> Please rename to 'pmdp'.
> 
Will do.

Alongside patch 4 usage of pmdpp and renaming 'pudpp' to 'pudp'.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
