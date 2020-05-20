Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B60E41DBA72
	for <lists+linux-nvdimm@lfdr.de>; Wed, 20 May 2020 19:02:12 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 72D961003F541;
	Wed, 20 May 2020 09:58:45 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=batv+9495f3cb3d3d1d0fc876+6114+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E917A1003F540
	for <linux-nvdimm@lists.01.org>; Wed, 20 May 2020 09:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wKFuUlL7y/Hz3vNl2ArSrtbtHfVShgj63vVocK+vAT4=; b=mFGJE3B/bWr+OnkaK0M7OgjxVz
	wGGnFeNf+j/uHBys9ZDrrxgbINOWDtHhpS2HfeOtHJcmou1tqjHmTpEIpdCiNZdePR1tp03BecMJ0
	KTf2waZP87WxMoPBHf8tXVMtZhGXfsLoWEtU8rxQBitP8mWvtAhnjzrDuTsWNIDGtH5ITb+0/z5G8
	X6gx+BQ+6aQSQTMugFQDbL6YAb6gWqKMkMfoJ3iuTH8hjh1paZm2IBbibjPpmXB6C0oRRmxwQ3lZ/
	neobDsvt/oWDkXcKVM9Y+hHH0GX22YdvPDX2USArnwlumE5N1EBCLNolK6CQotjua6vhR/iOCFCb9
	auljKSPg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbS6R-0000C5-R2; Wed, 20 May 2020 17:01:59 +0000
Date: Wed, 20 May 2020 10:01:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [RESEND PATCH v7 2/5] seq_buf: Export seq_buf_printf() to
 external modules
Message-ID: <20200520170159.GA22544@infradead.org>
References: <20200519190058.257981-1-vaibhav@linux.ibm.com>
 <20200519190058.257981-3-vaibhav@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200519190058.257981-3-vaibhav@linux.ibm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: SKM52QVWYUZACNFWVEJCZAIMBH5ATVOW
X-Message-ID-Hash: SKM52QVWYUZACNFWVEJCZAIMBH5ATVOW
X-MailFrom: BATV+9495f3cb3d3d1d0fc876+6114+infradead.org+hch@bombadil.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>, Piotr Maziarz <piotrx.maziarz@linux.intel.com>, Cezary Rojewski <cezary.rojewski@intel.com>, Borislav Petkov <bp@alien8.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SKM52QVWYUZACNFWVEJCZAIMBH5ATVOW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

s/seq_buf: Export seq_buf_printf() to external modules/
  seq_buf: export seq_buf_printf/
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
