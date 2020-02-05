Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6827153830
	for <lists+linux-nvdimm@lfdr.de>; Wed,  5 Feb 2020 19:33:08 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DE2EE10FC33EC;
	Wed,  5 Feb 2020 10:36:24 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=batv+a2b935cbc3c12af13a1b+6009+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 02E5610FC33EB
	for <linux-nvdimm@lists.01.org>; Wed,  5 Feb 2020 10:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oi0rYdHcN37UQwcE4W2Lf2qMT1dsNyOX7dXRkMNyxwQ=; b=jgtY6wBeNBXp+deQEJvDcaqhHY
	mnKujaTA42yDgx6r3hij7V5PcRgRIrQoO29YvhVsBrmIw0UNr1ZUUfy4gBdQRVwVaZt/97uNiZ3uC
	8fcXArL6aJLYmjLXZzl0u2zRNQSvF12Pr2M+CjchPCZMY4wDLmoKMgIrLQBZATuMLk3MKrKTOQuH/
	T46NKpO+SOp0P1hT0qR78bPUsglq6eApCQfUM1vwQZna40/vsQLrS4wKuz+f3do46PY4rN5Z9XPL6
	dBoiynAItBC9/UKF8lxcnobQvVl7CIl6yxfON1YeqWKhTMkyVIwyAFFA7dtD4o0VGi6rsaY1XHK68
	s6LxYFKg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1izPU1-0001ax-0N; Wed, 05 Feb 2020 18:33:05 +0000
Date: Wed, 5 Feb 2020 10:33:04 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 3/5] dm,dax: Add dax zero_page_range operation
Message-ID: <20200205183304.GC26711@infradead.org>
References: <20200203200029.4592-1-vgoyal@redhat.com>
 <20200203200029.4592-4-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200203200029.4592-4-vgoyal@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: UHRNW3TX3BX7MB72VFKISAVSO336ZLEZ
X-Message-ID-Hash: UHRNW3TX3BX7MB72VFKISAVSO336ZLEZ
X-MailFrom: BATV+a2b935cbc3c12af13a1b+6009+infradead.org+hch@bombadil.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, hch@infradead.org, dm-devel@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UHRNW3TX3BX7MB72VFKISAVSO336ZLEZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 03, 2020 at 03:00:27PM -0500, Vivek Goyal wrote:
> This patch adds support for dax zero_page_range operation to dm targets.

Any way to share the code with the dax copy iter here?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
