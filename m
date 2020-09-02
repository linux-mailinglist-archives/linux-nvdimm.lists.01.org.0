Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A1C25B1EB
	for <lists+linux-nvdimm@lfdr.de>; Wed,  2 Sep 2020 18:45:11 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 42A6B13AAF737;
	Wed,  2 Sep 2020 09:45:09 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.81; helo=us-smtp-delivery-1.mimecast.com; envelope-from=msnitzer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com [207.211.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 339B313AA0E4F
	for <linux-nvdimm@lists.01.org>; Wed,  2 Sep 2020 09:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1599065105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rCORYoTptCNctcHmeRURsRJc20YTgKGms7zHw+aGUWY=;
	b=DHGIkFws+fpFi1KX6ZyecF+rujyp6GPwKgUD5M6HLa2kkqGdW7ue4oIG/wRf48+rVdyOrn
	EuYBQoxU+DAHM3cCW3n5cP04DRDlL5v8+M/C8BzSsNC9yHCePiwFB3s0YfzDQ6slSwyFiW
	PQ4pGUkqYDnQJr1W0EAGTf6Otdx+mmc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-plyNLgTEO9CPua6cmCO_NA-1; Wed, 02 Sep 2020 12:45:02 -0400
X-MC-Unique: plyNLgTEO9CPua6cmCO_NA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4631107B765;
	Wed,  2 Sep 2020 16:45:00 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CA4CC5C1C4;
	Wed,  2 Sep 2020 16:44:57 +0000 (UTC)
Date: Wed, 2 Sep 2020 12:44:57 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Coly Li <colyli@suse.de>
Subject: Re: flood of "dm-X: error: dax access failed" due to 5.9 commit
 231609785cbfb
Message-ID: <20200902164456.GA5928@redhat.com>
References: <20200902160432.GA5513@redhat.com>
 <df0203fa-7f75-53ac-8bf1-79a1c861918e@suse.de>
MIME-Version: 1.0
In-Reply-To: <df0203fa-7f75-53ac-8bf1-79a1c861918e@suse.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=msnitzer@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Message-ID-Hash: J4JQ4YHAICPZNWMUKUFXLHSG2HDMRM6Y
X-Message-ID-Hash: J4JQ4YHAICPZNWMUKUFXLHSG2HDMRM6Y
X-MailFrom: msnitzer@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, linux-nvdimm@lists.01.org, dm-devel@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/J4JQ4YHAICPZNWMUKUFXLHSG2HDMRM6Y/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 02 2020 at 12:40pm -0400,
Coly Li <colyli@suse.de> wrote:

> On 2020/9/3 00:04, Mike Snitzer wrote:
> > 5.9 commit 231609785cbfb ("dax: print error message by pr_info() in
> > __generic_fsdax_supported()") switched from pr_debug() to pr_info().
> > 
> > The justification in the commit header is really inadequate.  If there
> > is a problem that you need to drill in on, repeat the testing after
> > enabling the dynamic debugging.
> > 
> > Otherwise, now all DM devices that aren't layered on DAX capable devices
> > spew really confusing noise to users when they simply activate their
> > non-DAX DM devices:
> > 
> > [66567.129798] dm-6: error: dax access failed (-5)
> > [66567.134400] dm-6: error: dax access failed (-5)
> > [66567.139152] dm-6: error: dax access failed (-5)
> > [66567.314546] dm-2: error: dax access failed (-95)
> > [66567.319380] dm-2: error: dax access failed (-95)
> > [66567.324254] dm-2: error: dax access failed (-95)
> > [66567.479025] dm-2: error: dax access failed (-95)
> > [66567.483713] dm-2: error: dax access failed (-95)
> > [66567.488722] dm-2: error: dax access failed (-95)
> > [66567.494061] dm-2: error: dax access failed (-95)
> > [66567.498823] dm-2: error: dax access failed (-95)
> > [66567.503693] dm-2: error: dax access failed (-95)
> > 
> > commit 231609785cbfb must be reverted.
> > 
> > Please advise, thanks.
> 
> Adrian Huang from Lenovo posted a patch, which titled: dax: do not print
> error message for non-persistent memory block device
> 
> It fixes the issue, but no response for now. Maybe we should take this fix.

OK, yes sounds like it.  It was merged and is commit c2affe920b0e066
("dax: do not print error message for non-persistent memory block
device")

Thanks for the info.
Mike
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
