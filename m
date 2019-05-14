Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE4D1CF6E
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 May 2019 20:53:30 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4A58E2125F1EA;
	Tue, 14 May 2019 11:53:28 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=156.151.31.86; helo=userp2130.oracle.com;
 envelope-from=jane.chu@oracle.com; receiver=linux-nvdimm@lists.01.org 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 021722122CAB4
 for <linux-nvdimm@lists.01.org>; Tue, 14 May 2019 11:53:25 -0700 (PDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4EIiFBn023209;
 Tue, 14 May 2019 18:53:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type; s=corp-2018-07-02;
 bh=31OE527D1rWAirfTB877GDNGJC88ito9E6Gvugy4RfM=;
 b=LUSkCcyZ25L9H7hizXGBi8Ar9iUmwXy5ekupLpY0mAcKTKhjjc7wtT0Rk2SaKOO0uJX/
 1zm5bhxPwY/5hRN6PalXPtRuWcRrmMuoaFQD5mSMxx2l5sImxbTiYJjAMaAvHl7C9br7
 FaxmShgLq7rOtOr6HIFZ4nbXNPuvZ9MXVt9ktoTEjGuFk3GTSa77NpRkm4ot9SEFzzdf
 Zu2HhJMNRVNxYr9OveBl9ZozmcAbTEWd/M+sflIC87c55xPG9MGA4N3OdwvvmKOYVLOA
 Y+QiwHa0ZX0wAM0Ow5w9xmYwxYaBIVYEebqbMPkteoIN4cTss8OLwb+7BQNTW4LLC+EJ Rw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2sdnttr78x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 May 2019 18:53:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4EIncCx181596;
 Tue, 14 May 2019 18:51:09 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2sdnqjqv4u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 May 2019 18:51:09 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4EIp6Q1024918;
 Tue, 14 May 2019 18:51:06 GMT
Received: from [10.159.158.136] (/10.159.158.136)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 14 May 2019 11:51:06 -0700
Subject: Re: [PATCH v2 0/6] mm/devm_memremap_pages: Fix page release race
To: Logan Gunthorpe <logang@deltatee.com>,
 Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org
References: <155727335978.292046.12068191395005445711.stgit@dwillia2-desk3.amr.corp.intel.com>
 <059859ca-3cc8-e3ff-f797-1b386931c41e@deltatee.com>
 <17ada515-f488-d153-90ef-7a5cc5fefb0f@deltatee.com>
From: Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <8a7cfa6b-6312-e8e5-9314-954496d2f6ce@oracle.com>
Date: Tue, 14 May 2019 11:51:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <17ada515-f488-d153-90ef-7a5cc5fefb0f@deltatee.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9257
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905140126
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9257
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905140126
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
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
Cc: linux-nvdimm@lists.01.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 5/13/2019 12:22 PM, Logan Gunthorpe wrote:

>
> On 2019-05-08 11:05 a.m., Logan Gunthorpe wrote:
>>
>> On 2019-05-07 5:55 p.m., Dan Williams wrote:
>>> Changes since v1 [1]:
>>> - Fix a NULL-pointer deref crash in pci_p2pdma_release() (Logan)
>>>
>>> - Refresh the p2pdma patch headers to match the format of other p2pdma
>>>     patches (Bjorn)
>>>
>>> - Collect Ira's reviewed-by
>>>
>>> [1]: https://lore.kernel.org/lkml/155387324370.2443841.574715745262628837.stgit@dwillia2-desk3.amr.corp.intel.com/
>> This series looks good to me:
>>
>> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
>>
>> However, I haven't tested it yet but I intend to later this week.
> I've tested libnvdimm-pending which includes this series on my setup and
> everything works great.

Just wondering in a difference scenario where pmem pages are exported to
a KVM guest, and then by mistake the user issues "ndctl destroy-namespace -f",
will the kernel wait indefinitely until the user figures out to kill the guest
and release the pmem pages?

thanks,
-jane
  

>
> Thanks,
>
> Logan
> _______________________________________________
> Linux-nvdimm mailing list
> Linux-nvdimm@lists.01.org
> https://lists.01.org/mailman/listinfo/linux-nvdimm
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
