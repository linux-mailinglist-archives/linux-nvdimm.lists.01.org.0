Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 865D02EE743
	for <lists+linux-nvdimm@lfdr.de>; Thu,  7 Jan 2021 21:54:23 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C142D100EAB78;
	Thu,  7 Jan 2021 12:54:21 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::150; helo=mail-il1-x150.google.com; envelope-from=3-ht3xxejdmu4zyl3lyw5nl37ntgdrxltw.nzxwty58-y6otxxwt343.bc.z2r@trix.bounces.google.com; receiver=<UNKNOWN> 
Received: from mail-il1-x150.google.com (mail-il1-x150.google.com [IPv6:2607:f8b0:4864:20::150])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0FF06100EAB78
	for <linux-nvdimm@lists.01.org>; Thu,  7 Jan 2021 12:54:17 -0800 (PST)
Received: by mail-il1-x150.google.com with SMTP id c13so8017093ilg.22
        for <linux-nvdimm@lists.01.org>; Thu, 07 Jan 2021 12:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:message-id:date:subject:from:to;
        bh=4xapv1rTn9EMeoaiVyfOSV9kr4twl7cq0WVSG+dts5Y=;
        b=GFPyz4yJujxtWM/EOrqez+pKrgTFzZQcmsxuCQmjcpFYVefUllb6rKX/QpL3vLgg8d
         1ia5ZNiDWSyp5cq51AexU1d0fS3cGqJYLTokgFwrEwQK6K/m7f2KriA0OadaL9O6ZQFr
         lbuvBv63A1l3heBn+NkzCbb8F+afSAwP7TM9jG778r4YPI9dVgsU5K+T+teGeJK7t4vw
         5MtOdjAa+naTi/9KKDHUFOzAcxELrmDivMlaWZmZbP4ZLvoUz/Ko0we19vjcoIP/Vmhn
         +Plr161P8oeUqo9jiGM+a2Kvn+RLmiRB2BtmMmtDNp1H56rgwBGZlR4T/yHOFDeAuOLa
         jIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:message-id:date:subject
         :from:to;
        bh=4xapv1rTn9EMeoaiVyfOSV9kr4twl7cq0WVSG+dts5Y=;
        b=GIAUnX+4dqkmxtVQWselXkDX0Jz+DcS7/PVAQ5IUe/KprhNw1BcMtT3Z/CHVhxc/od
         O5VE+aXfWBONME7TsVt1GKxgDoLeVImgmfnN5Kp3gSFwyVtohZhpdhoPfD+sv/NTNJtP
         +szn59kDNvdkYBga+DE7vI849zK+D/KXcuuI8QfrD+P3hvV6+P47u7C5dSz32XOYU4ux
         Kf8wQpjZ7kMe4JzDMyBL0TQGKV6ZW4Onm3BNcJ++oPjbudyCOgie8YvG6mmxQi9c2NbC
         d/yVQg0LuJNfvO688EIo80YBtukxXjepXqntl8KGUFVdV8MtrNepigSgs8/N9ibo0rSf
         fDUQ==
X-Gm-Message-State: AOAM531aiNujNTpivCDe0MAz58A424O8cbhF5cVIFjkYg4PTQ/z0WulF
	1G0ABaLsv4Oi5bQW+zkdqW9KTBnJfmGGrx1ZX+ul
MIME-Version: 1.0
X-Received: by 2002:a5e:a614:: with SMTP id q20mt2966785ioi.198.1610052856756;
 Thu, 07 Jan 2021 12:54:16 -0800 (PST)
X-No-Auto-Attachment: 1
Message-ID: <00000000000098d05c05b855a46c@google.com>
Date: Thu, 07 Jan 2021 20:54:17 +0000
Subject: Re: Can I trust You?
From: tonasanlucaswci52@gmail.com
To: linux-nvdimm@lists.01.org
Message-ID-Hash: Z74SXPLRHSQ4JXKZELB6W6GCX4OJTNM2
X-Message-ID-Hash: Z74SXPLRHSQ4JXKZELB6W6GCX4OJTNM2
X-MailFrom: 3-HT3XxEJDMU4zyl3lyw5nl37ntGDrxltw.nzxwty58-y6otxxwt343.BC.z2r@trix.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: tonasanlucaswci52@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Z74SXPLRHSQ4JXKZELB6W6GCX4OJTNM2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
Content-Transfer-Encoding: 7bit

I've invited you to fill in the following form:
Untitled form

To fill it in, visit:
https://docs.google.com/forms/d/e/1FAIpQLSdPIfhNUbRZcTHfSy6N2Izc893sYWTnMZzxSDgitBXal5M24A/viewform?vc=0&amp;c=0&amp;w=1&amp;flr=0&amp;usp=mail_form_link

Dearest One,

Permit me to inform you of my desire of going into a business
relationship with you. I am quite aware that my message will come to
you as a surprise because it is indeed very strange for someone you
have not met before to contact you in this regard.

I am Ms Joyce Kabore the only daughter of the late Chief. And Mrs.
Bande Kabore. My father was a very wealthy Cocoa merchant, an ally of
President Blaise Compaore in Ouagadougou, the economic capital city of
Burkina Faso, my father was poisoned by his business associates on one
of their outings on a business trip during the coup that ended 27
years of President Blaise Compaore rain. My mother died when I was a
baby and since then my father took me so special. Before the death of
my father in October 2017 in a private hospital here in Burkina Faso
He secretly called me on his bed side and told me that he has the sum
of (Seven million, five hundred thousand United State Dollars).USD
($7.500, 000, 00) left in a fixed / suspense account in one of the
prime banks in Asia, that he used my name as his only
daughter for the next of Kin in depositing the fund. He also explained
to me that it was because of this wealth that he was poisoned by his
business associates; he told me where he hid the documents. That I
should seek a foreign partner in a country of my choice where I will
transfer this money and use it for investment purposes such as real
estate or hotel management.

Dear, I am honorably seeking your assistance in the following ways:
(1) To provide a bank account into which this money would be transferred to.
(2) To serve as a guardian of this fund since I am only 17 years old.
(3) To make arrangements for me to come over to your country to
further my education and also to secure a resident permit in your
country. Moreover, Dear I am willing to offer you 15% of the total sum
as compensation for your effort/ input after the successful transfer
of this fund into your nominated account overseas.

Furthermore, please indicate your options towards assisting me as I
believe that this transaction would be concluded within seven (7)
days, you signify your interest to assist me, anticipating hearing
from you soonest.

Kindly keep this as a top secret as I am still hiding from my late
father business partner, because of the documents of this fund that
are in my position.

Thanks and God bless you.
Yours Sincerely,
Ms Joyce Kabore


Google Forms: Create and analyse surveys.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
