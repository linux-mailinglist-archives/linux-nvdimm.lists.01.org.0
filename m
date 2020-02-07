Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDE3155BDC
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 Feb 2020 17:34:21 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6EA1A10FC3583;
	Fri,  7 Feb 2020 08:37:37 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.61; helo=us-smtp-delivery-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com [205.139.110.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 97A831007A826
	for <linux-nvdimm@lists.01.org>; Fri,  7 Feb 2020 08:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1581093255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3QRTAga3VQ9v/y6z6auDep6PqNUpoH7brYD9i0zJlUs=;
	b=GEqisqCUyTNTz6qdmaj3TyRirvRTpiX5U59uMEG3j17RreG1+wLTHeb+FhVxFbUcQ/P2wO
	FkLp+oIIXlk1f5neLbZSJ6Z59eE67WwXFyMqJLr1652f3FzF8Bf3f8eZyivLSepTiz0MZV
	Hx7IvjCYMfs+alrnHgKDuHizSASV4uE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-FcrUSCs0P4araZ4RMEpJ8Q-1; Fri, 07 Feb 2020 11:34:05 -0500
X-MC-Unique: FcrUSCs0P4araZ4RMEpJ8Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 896671005513;
	Fri,  7 Feb 2020 16:34:04 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F08FD790E1;
	Fri,  7 Feb 2020 16:34:01 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 63FFF220A24; Fri,  7 Feb 2020 11:34:01 -0500 (EST)
Date: Fri, 7 Feb 2020 11:34:01 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 3/5] dm,dax: Add dax zero_page_range operation
Message-ID: <20200207163401.GB11998@redhat.com>
References: <20200203200029.4592-1-vgoyal@redhat.com>
 <20200203200029.4592-4-vgoyal@redhat.com>
 <20200205183304.GC26711@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200205183304.GC26711@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Message-ID-Hash: WX7Z54KW7TMPIZMZJEV5V2E2UG4P4CHA
X-Message-ID-Hash: WX7Z54KW7TMPIZMZJEV5V2E2UG4P4CHA
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, dm-devel@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WX7Z54KW7TMPIZMZJEV5V2E2UG4P4CHA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 05, 2020 at 10:33:04AM -0800, Christoph Hellwig wrote:
> On Mon, Feb 03, 2020 at 03:00:27PM -0500, Vivek Goyal wrote:
> > This patch adds support for dax zero_page_range operation to dm targets.
> 
> Any way to share the code with the dax copy iter here?

Had a look at it and can't think of a good way of sharing the code. If
you have something specific in mind, I am happy to make changes.

Vivek
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
