Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991A065066
	for <lists+linux-nvdimm@lfdr.de>; Thu, 11 Jul 2019 05:09:03 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 534F2212B7DAA;
	Wed, 10 Jul 2019 20:11:27 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id DBAD0212B7DA3
 for <linux-nvdimm@lists.01.org>; Wed, 10 Jul 2019 20:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kCf95klSl4II9ASRgUO/dZ/BhEcTH5foAFI3YRAMrm8=; b=J6mQidU9Nu9jXP6cFQwFeAnGJ
 xO6UGwej3f3LcKNTSHthSc5l6QnV9t/41sADhbPOtxwGJhusuqcizgdLeP6A0kw3iBBfdHJRpSfmH
 HrFk1NE5ZhA60nEQ0f9kRYvHq9qW4BMY+rJnC41EK3bl1XcDYqvjRceaeLT967PsfjjZyFP2zaJz6
 JsAXd3+NxpWOEegHY72GEy27CsmwX4tUoVZUaBek+uXF7HqnCAJ/0iblm1DktLNdt2bQUMAAZXlWZ
 wXzYdRlP5JKjh9XlOpX3EA+YNRBDQAp0jhOLmGIXk/bqCHYDMwnqNSrVanzspV5s9nVHue31DN4lb
 MtQRKZtSA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red
 Hat Linux)) id 1hlPS3-0000Cr-Jj; Thu, 11 Jul 2019 03:08:55 +0000
Date: Wed, 10 Jul 2019 20:08:55 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] dax: Fix missed PMD wakeups
Message-ID: <20190711030855.GO32320@bombadil.infradead.org>
References: <CAPcyv4jgs5LTtTXR+2CyfbjJE85B_eoPFuXQsGBDnVMo41Jawg@mail.gmail.com>
 <20190703195302.GJ1729@bombadil.infradead.org>
 <CAPcyv4iPNz=oJyc_EoE-mC11=gyBzwMKbmj1ZY_Yna54=cC=Mg@mail.gmail.com>
 <20190704032728.GK1729@bombadil.infradead.org>
 <20190704165450.GH31037@quack2.suse.cz>
 <20190704191407.GM1729@bombadil.infradead.org>
 <CAPcyv4gUiDw8Ma9mvbW5BamQtGZxWVuvBW7UrOLa2uijrXUWaw@mail.gmail.com>
 <20190705191004.GC32320@bombadil.infradead.org>
 <CAPcyv4jVARa38Qc4NjQ04wJ4ZKJ6On9BbJgoL95wQqU-p-Xp_w@mail.gmail.com>
 <20190710190204.GB14701@quack2.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190710190204.GB14701@quack2.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
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
Cc: Seema Pandit <seema.pandit@intel.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, Boaz Harrosh <openosd@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>, Robert Barror <robert.barror@intel.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jul 10, 2019 at 09:02:04PM +0200, Jan Kara wrote:
> @@ -848,7 +853,7 @@ static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
>  	if (unlikely(dax_is_locked(entry))) {
>  		void *old_entry = entry;
>  
> -		entry = get_unlocked_entry(xas);
> +		entry = get_unlocked_entry(xas, 0);
>  
>  		/* Entry got punched out / reallocated? */
>  		if (!entry || WARN_ON_ONCE(!xa_is_value(entry)))

I'm not sure about this one.  Are we sure there will never be a dirty
PMD entry?  Even if we can't create one today, it feels like a bit of
a landmine to leave for someone who creates one in the future.

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
