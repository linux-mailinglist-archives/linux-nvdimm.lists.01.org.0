Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 970C825A545
	for <lists+linux-nvdimm@lfdr.de>; Wed,  2 Sep 2020 08:00:09 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CF7D713A5DCFD;
	Tue,  1 Sep 2020 23:00:07 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=song@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EE67413A5DCFD
	for <linux-nvdimm@lists.01.org>; Tue,  1 Sep 2020 23:00:05 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 592AD207EA
	for <linux-nvdimm@lists.01.org>; Wed,  2 Sep 2020 06:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599026405;
	bh=qB+hJ64dFeZRc55gn05GV3vmMdd4XqXGRfV9RvpoPjM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=0qJu9pLJ4E1vrW1ZCOrx22K5hPkVXWi4ywQze2MMxFBe/K5cPfkOuOqBNt9LPwaDg
	 ZLrPaLIh81y83xpORfZ+dCgHhd49hoeXv9J8ZgsfKcp/G5G2kRmTyYl1K895tjJKXX
	 QjIDXFUXqjS0LTSdRPNSKdYJnpJZkVkN2EyBpTcg=
Received: by mail-lj1-f171.google.com with SMTP id h19so4366602ljg.13
        for <linux-nvdimm@lists.01.org>; Tue, 01 Sep 2020 23:00:05 -0700 (PDT)
X-Gm-Message-State: AOAM531JG1byEq+aNev0CB5FdayQSZ/J9BVGn4pMJWQemYdAp5YowYw9
	OBBbKGaLUfv4aR8OOiP/mC/zm1HoZgn9xTDcbaU=
X-Google-Smtp-Source: ABdhPJwf3HULiufgbpwKVoPwmf+LkIKFmte7J3KnU2uOXqQt3v5M5F/QoyNcLdziLtm9PrTb/1L0NAY4kWOOlCFV810=
X-Received: by 2002:a2e:8597:: with SMTP id b23mr2427127lji.41.1599026403505;
 Tue, 01 Sep 2020 23:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200901155748.2884-1-hch@lst.de> <20200901155748.2884-10-hch@lst.de>
In-Reply-To: <20200901155748.2884-10-hch@lst.de>
From: Song Liu <song@kernel.org>
Date: Tue, 1 Sep 2020 22:59:52 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7YKTHsWnqv22gq6VEz29=abYk7ADsxcQr9q3_kGZuiXw@mail.gmail.com>
Message-ID: <CAPhsuW7YKTHsWnqv22gq6VEz29=abYk7ADsxcQr9q3_kGZuiXw@mail.gmail.com>
Subject: Re: [PATCH 9/9] block: remove revalidate_disk()
To: Christoph Hellwig <hch@lst.de>
Message-ID-Hash: TWRRK4ARX7RR3FNJGK5M37JJVQ5PJBJJ
X-Message-ID-Hash: TWRRK4ARX7RR3FNJGK5M37JJVQ5PJBJJ
X-MailFrom: song@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>, dm-devel@redhat.com, open list <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org, nbd@other.debian.org, ceph-devel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-raid <linux-raid@vger.kernel.org>, linux-nvdimm@lists.01.org, linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TWRRK4ARX7RR3FNJGK5M37JJVQ5PJBJJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Sep 1, 2020 at 9:00 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Remove the now unused helper.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Song Liu <song@kernel.org>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
