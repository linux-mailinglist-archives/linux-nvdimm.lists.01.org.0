Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 831931A571
	for <lists+linux-nvdimm@lfdr.de>; Sat, 11 May 2019 00:45:35 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 984AF2126CFAB;
	Fri, 10 May 2019 15:45:33 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=156.151.31.86; helo=userp2130.oracle.com;
 envelope-from=mike.kravetz@oracle.com; receiver=linux-nvdimm@lists.01.org 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 7D570212657B2
 for <linux-nvdimm@lists.01.org>; Fri, 10 May 2019 15:45:31 -0700 (PDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4AMiYvu139156;
 Fri, 10 May 2019 22:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=bf8P4q788pObPSRhE2yikT3tYYSQpmCfY0xoTw+mRbc=;
 b=tJDg3KFbDYIWEVqN4zRx/qTj/SM3kNWXyLq8DekKk43DPTy4EJHOJoil4dQOslSkD0Fq
 8iunHzoBxOxSlelf6JLFmdzQj8nXkCwduTFP+mohuZ+4V+/7WVXDuCxhJrPY1cft9uTr
 VA5djX2Z2BfHHiFh2M0+dgE6PGwYX3rNP04HmZlOrNHmOWNZXxfBJumAOJDD5eVF04g6
 XPVd8mPBJD+Ad9RnRpO5yydcWexPYUKDqDWwZvF7uDkbGFCegZTnQpN+9FxA5Ch0syFd
 ikPpnIjYazDAUp4v/QAMiW7CUYHo9JQkntMVr4FFPQkiTysvRcYATetsKTdoJc9xBSWY Xg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2s94bgkuj5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 May 2019 22:45:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4AMhSbp190646;
 Fri, 10 May 2019 22:45:12 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2s94ahm8f7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 May 2019 22:45:11 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4AMj5kX031257;
 Fri, 10 May 2019 22:45:05 GMT
Received: from [192.168.1.222] (/71.63.128.209)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 10 May 2019 15:45:05 -0700
Subject: Re: [PATCH, RFC 2/2] Implement sharing/unsharing of PMDs for FS/DAX
To: Larry Bassel <larry.bassel@oracle.com>,
 Matthew Wilcox <willy@infradead.org>
References: <1557417933-15701-1-git-send-email-larry.bassel@oracle.com>
 <1557417933-15701-3-git-send-email-larry.bassel@oracle.com>
 <20190509164914.GA3862@bombadil.infradead.org>
 <20190510161607.GB27674@ubuette>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <af218b46-ece3-1189-e43c-209ec5cf1022@oracle.com>
Date: Fri, 10 May 2019 15:45:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190510161607.GB27674@ubuette>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9253
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905100144
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9253
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905100144
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
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 5/10/19 9:16 AM, Larry Bassel wrote:
> On 09 May 19 09:49, Matthew Wilcox wrote:
>> On Thu, May 09, 2019 at 09:05:33AM -0700, Larry Bassel wrote:
>>> This is based on (but somewhat different from) what hugetlbfs
>>> does to share/unshare page tables.
>>
>> Wow, that worked out far more cleanly than I was expecting to see.
> 
> Yes, I was pleasantly surprised. As I've mentioned already, I 
> think this is at least partially due to the nature of DAX.

I have not looked in detail to make sure this is indeed all the places you
need to hook and special case for sharing/unsharing.  Since this scheme is
somewhat like that used for hugetlb, I just wanted to point out some nasty
bugs related to hugetlb PMD sharing that were fixed last year.

5e41540c8a0f hugetlbfs: fix kernel BUG at fs/hugetlbfs/inode.c:444!
dff11abe280b hugetlb: take PMD sharing into account when flushing tlb/caches
017b1660df89 mm: migration: fix migration of huge PMD shared pages

The common issue in these is that when unmapping a page with a shared PMD
mapping you need to flush the entire shared range and not just the unmapped
page.  The above changes were hugetlb specific.  I do not know if any of
this applies in the case of DAX.
-- 
Mike Kravetz
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
