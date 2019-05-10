Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B81051A11F
	for <lists+linux-nvdimm@lfdr.de>; Fri, 10 May 2019 18:16:40 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 93A5F2126CF86;
	Fri, 10 May 2019 09:16:39 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=156.151.31.86; helo=userp2130.oracle.com;
 envelope-from=larry.bassel@oracle.com; receiver=linux-nvdimm@lists.01.org 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id CEA8F21268FA8
 for <linux-nvdimm@lists.01.org>; Fri, 10 May 2019 09:16:37 -0700 (PDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4AG8faU027900;
 Fri, 10 May 2019 16:16:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=ikyWD5tw3+Fa2klAswpQ3zG257Y/SYQKpSWVthHNaDQ=;
 b=jTF0ls4cyPu4lSedw8dhdKuv+vpLCt0VH3bLgDV9dvGWnvAVyKs31jEKWxt23CxWULLe
 KdKut0Bqm/TJKO/jJzsWynABfRlBIs8SJs4xOeoYPDb3KD0IHG7KBeJo5FxJgkD+AhXw
 CFZOeUR/vri7jNs8vQaK2dJgqlPlpR8RMPBLJXtdvnovfc14TIJ+JFvbc6f+Fi9by9yA
 RWK/2h22VkMcoqAg4JfIVgk6812bBv2eGY1biLyyCsCZxQB2gRme7+xocJJq6CDx/Fnz
 MrTVuCkawwTYm0ebBeD30KgDpatU8Jk+d022WGuXpOS2WXl2+Vd4j5rJ6u5GvvCCouIE Jg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2s94bgj6dx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 May 2019 16:16:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4AGFATp008060;
 Fri, 10 May 2019 16:16:21 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 2schw0gr97-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 May 2019 16:16:21 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4AGGIAk029191;
 Fri, 10 May 2019 16:16:18 GMT
Received: from ubuette (/75.80.107.76) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 10 May 2019 16:16:17 +0000
Date: Fri, 10 May 2019 09:16:07 -0700
From: Larry Bassel <larry.bassel@oracle.com>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH, RFC 2/2] Implement sharing/unsharing of PMDs for FS/DAX
Message-ID: <20190510161607.GB27674@ubuette>
References: <1557417933-15701-1-git-send-email-larry.bassel@oracle.com>
 <1557417933-15701-3-git-send-email-larry.bassel@oracle.com>
 <20190509164914.GA3862@bombadil.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190509164914.GA3862@bombadil.infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905100110
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905100110
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
Cc: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 mike.kravetz@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 09 May 19 09:49, Matthew Wilcox wrote:
> On Thu, May 09, 2019 at 09:05:33AM -0700, Larry Bassel wrote:
> > This is based on (but somewhat different from) what hugetlbfs
> > does to share/unshare page tables.
> 
> Wow, that worked out far more cleanly than I was expecting to see.

Yes, I was pleasantly surprised. As I've mentioned already, I 
think this is at least partially due to the nature of DAX.

> 
> > @@ -4763,6 +4763,19 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
> >  				unsigned long *start, unsigned long *end)
> >  {
> >  }
> > +
> > +unsigned long page_table_shareable(struct vm_area_struct *svma,
> > +				   struct vm_area_struct *vma,
> > +				   unsigned long addr, pgoff_t idx)
> > +{
> > +	return 0;
> > +}
> > +
> > +bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
> > +{
> > +	return false;
> > +}
> 
> I don't think you need these stubs, since the only caller of them is
> also gated by MAY_SHARE_FSDAX_PMD ... right?

These are also called in mm/hugetlb.c, but those calls are gated by
CONFIG_ARCH_WANT_HUGE_PMD_SHARE. In fact if this is not set (though
it is the default), then one wouldn't get FS/DAX sharing even if
MAY_SHARE_FSDAX_PMD is set. I think that this isn't what we want
(perhaps the real question is how should these two config options interact?).
Removing the stubs would fix this and I will make that change.

Maybe these two functions should be moved into mm/memory.c as well.

> 
> > +	vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
> > +		if (svma == vma)
> > +			continue;
> > +
> > +		saddr = page_table_shareable(svma, vma, addr, idx);
> > +		if (saddr) {
> > +			spmd = huge_pmd_offset(svma->vm_mm, saddr,
> > +					       vma_mmu_pagesize(svma));
> > +			if (spmd) {
> > +				get_page(virt_to_page(spmd));
> > +				break;
> > +			}
> > +		}
> > +	}
> 
> I'd be tempted to reduce the indentation here:
> 
> 	vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
> 		if (svma == vma)
> 			continue;
> 
> 		saddr = page_table_shareable(svma, vma, addr, idx);
> 		if (!saddr)
> 			continue;
> 
> 		spmd = huge_pmd_offset(svma->vm_mm, saddr,
> 					vma_mmu_pagesize(svma));
> 		if (spmd)
> 			break;
> 	}
> 
> 
> > +	if (!spmd)
> > +		goto out;
> 
> ... and move the get_page() down to here, so we don't split the
> "when we find it" logic between inside and outside the loop.
> 
> 	get_page(virt_to_page(spmd));
> 
> > +
> > +	ptl = pmd_lockptr(mm, spmd);
> > +	spin_lock(ptl);
> > +
> > +	if (pud_none(*pud)) {
> > +		pud_populate(mm, pud,
> > +			    (pmd_t *)((unsigned long)spmd & PAGE_MASK));
> > +		mm_inc_nr_pmds(mm);
> > +	} else {
> > +		put_page(virt_to_page(spmd));
> > +	}
> > +	spin_unlock(ptl);
> > +out:
> > +	pmd = pmd_alloc(mm, pud, addr);
> > +	i_mmap_unlock_write(mapping);
> 
> I would swap these two lines.  There's no need to hold the i_mmap_lock
> while allocating this PMD, is there?  I mean, we don't for the !may_share
> case.
> 

These were done in the style of functions already in mm/hugetlb.c and I was
trying to change as little as necessary in my copy of those. I agree that
these are good suggestions. One could argue that if these changes
were made, they should also be made in mm/hugetlb.c, though
this is perhaps beyond the scope of getting FS/DAX PMD sharing
implemented -- your thoughts?

Thanks for the review, I'll wait a few more days for other comments
and then send out a v2.

Larry
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
