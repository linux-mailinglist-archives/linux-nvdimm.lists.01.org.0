Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F255206937
	for <lists+linux-nvdimm@lfdr.de>; Wed, 24 Jun 2020 02:55:31 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BB9E810FC447E;
	Tue, 23 Jun 2020 17:55:29 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.81; helo=us-smtp-delivery-1.mimecast.com; envelope-from=dhowells@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com [207.211.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 736A410FC3C35
	for <linux-nvdimm@lists.01.org>; Tue, 23 Jun 2020 17:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1592960125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l8YDKYWSS8vDlTiiBW94TviByEXAP7JxXxS7ijuo3BU=;
	b=BawIVNzq0/V3zwO1P47j85QcP9nPRgvep5V9tmuvh79MnxN3J2O6KfS0gQe4ufvnvC+eT3
	YIWFiWsl6kxzhmRXuvA24BdbaFLNnXv8JjSG5gYp8RHMRLYB7YV+MLJsCDBX9U6jPCYu2Q
	qAtYBkjuPFqHl5/9noivbQwWU6UpXzg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-SUNRbfhUNlOrRx30UX_RVQ-1; Tue, 23 Jun 2020 20:55:22 -0400
X-MC-Unique: SUNRbfhUNlOrRx30UX_RVQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C601804001;
	Wed, 24 Jun 2020 00:55:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-66.rdu2.redhat.com [10.10.114.66])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 032357CCF9;
	Wed, 24 Jun 2020 00:55:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAPcyv4g+T+GK4yVJs8bTT1q90SFDpFYUSL9Pk_u8WZROhREPkw@mail.gmail.com>
References: <CAPcyv4g+T+GK4yVJs8bTT1q90SFDpFYUSL9Pk_u8WZROhREPkw@mail.gmail.com> <1503686.1591113304@warthog.procyon.org.uk> <23219b787ed1c20a63017ab53839a0d1c794ec53.camel@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [GIT PULL] General notification queue and key notifications
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3015560.1592960116.1@warthog.procyon.org.uk>
Date: Wed, 24 Jun 2020 01:55:16 +0100
Message-ID: <3015561.1592960116@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Message-ID-Hash: AMT662QJFWOL3CZUWPYDRGCLOYNJN32O
X-Message-ID-Hash: AMT662QJFWOL3CZUWPYDRGCLOYNJN32O
X-MailFrom: dhowells@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: dhowells@redhat.com, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "raven@themaw.net" <raven@themaw.net>, "kzak@redhat.com" <kzak@redhat.com>, "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "dray@redhat.com" <dray@redhat.com>, "swhiteho@redhat.com" <swhiteho@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "mszeredi@redhat.com" <mszeredi@redhat.com>, "jlayton@redhat.com" <jlayton@redhat.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "andres@anarazel.de" <andres@anarazel.de>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AMT662QJFWOL3CZUWPYDRGCLOYNJN32O/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> wrote:

> > This commit:
> >
> > >       keys: Make the KEY_NEED_* perms an enum rather than a mask
> >
> > ...upstream as:
> >
> >     8c0637e950d6 keys: Make the KEY_NEED_* perms an enum rather than a mask
> >
> > ...triggers a regression in the libnvdimm unit test that exercises the
> > encrypted keys used to store nvdimm passphrases. It results in the
> > below warning.
> 
> This regression is still present in tip of tree. David, have you had a
> chance to take a look?

nvdimm_lookup_user_key() needs to indicate to lookup_user_key() what it wants
the key for so that the appropriate security checks can take place in SELinux
and Smack.  Note that I have a patch in the works that changes this still
further.

Does setting the third argument of lookup_user_key() to KEY_NEED_SEARCH work
for you?

David
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
