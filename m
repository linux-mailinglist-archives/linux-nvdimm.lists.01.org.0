Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD582DD914
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Dec 2020 20:08:06 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 60F7E100EB832;
	Thu, 17 Dec 2020 11:08:04 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 47B42100EBB92
	for <linux-nvdimm@lists.01.org>; Thu, 17 Dec 2020 11:08:01 -0800 (PST)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BHJ03BY019861;
	Thu, 17 Dec 2020 19:07:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=oh0SNHyWNVwbsglPLcUm5qbnBh58fLOpSs/I7LpgU1o=;
 b=o06/bG/sI/t21QoKgeozho8JR76BxP+ChV5QlqIdnTuMm0LbFqBIut7FBhNIZ7jwoajj
 NJxG+lpngBlOtm63lizVL3I1U+Ywt6zYKmlk0qjkb0rHTf6eBNejwKP9jhlEoGALYegb
 Ks7KU2OFuFDgwuOl+n+2mUj1U7fIJSsQ+fpiQMoinf9oXKIGYd3Fjw1X5WH/C+9BK3BR
 5+rbPHP3JygELxdEBi3fe+gtm9aKMDn5KfDjlWZYrREOPSS7JZn8WHyu261RUcLsYTj4
 +z0ZHTYlvH7QOrqu90Z0gwacmVkoR8muhAsBZ0NMFUgDHo0ORamiXOCX3Xnapa20kA4d wg==
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by aserp2120.oracle.com with ESMTP id 35cntmf0fg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 17 Dec 2020 19:07:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BHJ0Hvt182564;
	Thu, 17 Dec 2020 19:05:48 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by userp3030.oracle.com with ESMTP id 35d7t0tewb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Dec 2020 19:05:47 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BHJ5hF0031564;
	Thu, 17 Dec 2020 19:05:43 GMT
Received: from [10.175.218.25] (/10.175.218.25)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 17 Dec 2020 11:05:43 -0800
Subject: Re: [PATCH RFC 7/9] mm/gup: Decrement head page once for group of
 subpages
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20201208172901.17384-1-joao.m.martins@oracle.com>
 <20201208172901.17384-9-joao.m.martins@oracle.com>
 <20201208193446.GP5487@ziepe.ca>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <cf5585f0-1352-e3ab-9dbf-0185ad0a1b31@oracle.com>
Date: Thu, 17 Dec 2020 19:05:37 +0000
MIME-Version: 1.0
In-Reply-To: <20201208193446.GP5487@ziepe.ca>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9838 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012170128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9838 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012170128
Message-ID-Hash: 4CR5TN25APNXJC7EGYGAJDQ4ZB6W4Q5L
X-Message-ID-Hash: 4CR5TN25APNXJC7EGYGAJDQ4ZB6W4Q5L
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-mm@kvack.org, linux-nvdimm@lists.01.org, Matthew Wilcox <willy@infradead.org>, Muchun Song <songmuchun@bytedance.com>, Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Daniel Jordan <daniel.m.jordan@oracle.com>, John Hubbard <jhubbard@nvidia.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4CR5TN25APNXJC7EGYGAJDQ4ZB6W4Q5L/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 12/8/20 7:34 PM, Jason Gunthorpe wrote:
>> @@ -274,6 +291,7 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
>>  				 bool make_dirty)
>>  {
>>  	unsigned long index;
>> +	int refs = 1;
>>  
>>  	/*
>>  	 * TODO: this can be optimized for huge pages: if a series of pages is
>> @@ -286,8 +304,9 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
>>  		return;
>>  	}
>>  
>> -	for (index = 0; index < npages; index++) {
>> +	for (index = 0; index < npages; index += refs) {
>>  		struct page *page = compound_head(pages[index]);
>> +
> 
> I think this is really hard to read, it should end up as some:
> 
> for_each_compond_head(page_list, page_list_len, &head, &ntails) {
>        		if (!PageDirty(head))
> 			set_page_dirty_lock(head, ntails);
> 		unpin_user_page(head, ntails);
> }
> 
> And maybe you open code that iteration, but that basic idea to find a
> compound_head and ntails should be computational work performed.
> 
> No reason not to fix set_page_dirty_lock() too while you are here.
> 

The wack of atomics you mentioned earlier you referred to, I suppose it
ends being account_page_dirtied(). See partial diff at the end.

I was looking at the latter part and renaming all the fs that supply
set_page_dirty()... But now my concern is whether it's really safe to
assume that filesystems that supply it ... have indeed the ability to dirty
@ntails pages. Functionally, fixing set_page_dirty_lock() means we don't call
set_page_dirty(head) @ntails times as it happens today, we would only call once
with ntails as argument.

Perhaps the safest thing to do is still to iterate over
@ntails and call .set_page_dirty(page) and instead introduce
a set_page_range_dirty() which individual filesystems can separately
supply and give precedence of ->set_page_range_dirty() as opposed
to ->set_page_dirty() ?

	Joao

--------------------->8------------------------------

diff --git a/mm/gup.c b/mm/gup.c
index 41ab3d48e1bb..5f8a0f16ab62 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -295,7 +295,7 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long
npages,
                 * next writeback cycle. This is harmless.
                 */
                if (!PageDirty(head))
-                       set_page_dirty_lock(head);
+                       set_page_range_dirty_lock(head, ntails);
                put_compound_head(head, ntails, FOLL_PIN);
        }
 }
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 088729ea80b2..4642d037f657 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2417,7 +2417,8 @@ int __set_page_dirty_no_writeback(struct page *page, unsigned int
ntails)
  *
  * NOTE: This relies on being atomic wrt interrupts.
  */
-void account_page_dirtied(struct page *page, struct address_space *mapping)
+void account_page_dirtied(struct page *page, struct address_space *mapping,
+                         unsigned int ntails)
 {
        struct inode *inode = mapping->host;

@@ -2425,17 +2426,18 @@ void account_page_dirtied(struct page *page, struct address_space
*mapping)

        if (mapping_can_writeback(mapping)) {
                struct bdi_writeback *wb;
+               int nr = ntails + 1;

                inode_attach_wb(inode, page);
                wb = inode_to_wb(inode);

-               __inc_lruvec_page_state(page, NR_FILE_DIRTY);
-               __inc_zone_page_state(page, NR_ZONE_WRITE_PENDING);
-               __inc_node_page_state(page, NR_DIRTIED);
-               inc_wb_stat(wb, WB_RECLAIMABLE);
-               inc_wb_stat(wb, WB_DIRTIED);
-               task_io_account_write(PAGE_SIZE);
-               current->nr_dirtied++;
+               mod_lruvec_page_state(page, NR_FILE_DIRTY, nr);
+               mod_zone_page_state(page_zone(page), NR_ZONE_WRITE_PENDING, nr);
+               mod_node_page_state(page_pgdat(page), NR_DIRTIED, nr);
+               __add_wb_stat(wb, WB_RECLAIMABLE, nr);
+               __add_wb_stat(wb, WB_DIRTIED, nr);
+               task_io_account_write(nr * PAGE_SIZE);
+               current->nr_dirtied += nr;
                this_cpu_inc(bdp_ratelimits);

                mem_cgroup_track_foreign_dirty(page, wb);
@@ -2485,7 +2487,7 @@ int __set_page_dirty_nobuffers(struct page *page, unsigned int ntails)
                xa_lock_irqsave(&mapping->i_pages, flags);
                BUG_ON(page_mapping(page) != mapping);
                WARN_ON_ONCE(!PagePrivate(page) && !PageUptodate(page));
-               account_page_dirtied(page, mapping);
+               account_page_dirtied(page, mapping, ntails);
                __xa_set_mark(&mapping->i_pages, page_index(page),
                                   PAGECACHE_TAG_DIRTY);
                xa_unlock_irqrestore(&mapping->i_pages, flags);
@@ -2624,6 +2626,27 @@ int set_page_dirty_lock(struct page *page)
 }
 EXPORT_SYMBOL(set_page_dirty_lock);

+/*
+ * set_page_range_dirty() is racy if the caller has no reference against
+ * page->mapping->host, and if the page is unlocked.  This is because another
+ * CPU could truncate the page off the mapping and then free the mapping.
+ *
+ * Usually, the page _is_ locked, or the caller is a user-space process which
+ * holds a reference on the inode by having an open file.
+ *
+ * In other cases, the page should be locked before running set_page_range_dirty().
+ */
+int set_page_range_dirty_lock(struct page *page, unsigned int ntails)
+{
+       int ret;
+
+       lock_page(page);
+       ret = set_page_range_dirty(page, ntails);
+       unlock_page(page);
+       return ret;
+}
+EXPORT_SYMBOL(set_page_range_dirty_lock);
+
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
