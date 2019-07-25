Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8597452E
	for <lists+linux-nvdimm@lfdr.de>; Thu, 25 Jul 2019 07:40:10 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6A405212DD34B;
	Wed, 24 Jul 2019 22:42:35 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=141.146.126.78; helo=aserp2120.oracle.com;
 envelope-from=jane.chu@oracle.com; receiver=linux-nvdimm@lists.01.org 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D42DE212DA5E3
 for <linux-nvdimm@lists.01.org>; Wed, 24 Jul 2019 22:42:33 -0700 (PDT)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6P5d0Xf078656;
 Thu, 25 Jul 2019 05:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=DIaad5qbirnDkeKlUJE4RYRnrPGQKiec4THTqLDSXrw=;
 b=IPH/9AVYiWVzq6wlgvo3F/88gUEHhrUGkzLM6HKQ3AmDJPgJ8FW1o+LAKoVFyJLNsUwb
 zsrH29WQGuIYFvvrTct1noJAWGP/8qtGXRkEr+gewJ/1f2dvoFCOpy3i9lZck/YnIK61
 jNr2CX38esOUkjQUYt0LsFbgzuHJIPziZ8qxVU66qow2iB++jbx1iY41Mr0DwIl6QHCA
 2ANpXPrK4JxlnkWQcrPaFf2m5BynwVihkJd0W4F9mSDy3r9CxoRka8aPoGoJUb0uyHbS
 YDvkMJudKzqg3boByZ4sZ9HKCuCpRp//23F3sY3O6NEQ4bNxLWaol7M+3AEhbFvKISaY NA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2tx61c1f6c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jul 2019 05:40:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6P5bmEi117255;
 Thu, 25 Jul 2019 05:40:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2tx60yn82x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jul 2019 05:40:01 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6P5dxBH003035;
 Thu, 25 Jul 2019 05:39:59 GMT
Received: from [10.159.158.5] (/10.159.158.5)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 24 Jul 2019 22:39:56 -0700
Subject: Re: [PATCH v2 0/1] mm/memory-failure: Poison read receives SIGKILL
 instead of SIGBUS issue
To: Dan Williams <dan.j.williams@intel.com>
References: <1564007603-9655-1-git-send-email-jane.chu@oracle.com>
 <CAPcyv4iqdbL+=boCciMTgUEn-GU1RQQmBJtNU9RHoV84XNMS+g@mail.gmail.com>
From: Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <fa353250-2ea2-3be3-5e4d-1ccf7dc06014@oracle.com>
Date: Wed, 24 Jul 2019 22:39:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4iqdbL+=boCciMTgUEn-GU1RQQmBJtNU9RHoV84XNMS+g@mail.gmail.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9328
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=986
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907250067
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9328
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907250067
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Linux MM <linux-mm@kvack.org>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 7/24/2019 3:52 PM, Dan Williams wrote:
> On Wed, Jul 24, 2019 at 3:35 PM Jane Chu <jane.chu@oracle.com> wrote:
>>
>> Changes in v2:
>>   - move 'tk' allocations internal to add_to_kill(), suggested by Dan;
> 
> Oh, sorry if it wasn't clear, this should move to its own patch that
> only does the cleanup, and then the follow on fix patch becomes
> smaller and more straightforward.
> 

Make sense, thanks! I'll split up the patch next.

thanks,
-jane
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
