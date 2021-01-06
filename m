Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7DD2EC338
	for <lists+linux-nvdimm@lfdr.de>; Wed,  6 Jan 2021 19:27:11 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4C979100EBBD8;
	Wed,  6 Jan 2021 10:27:09 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::b43; helo=mail-yb1-xb43.google.com; envelope-from=ruelskiirr@gmail.com; receiver=<UNKNOWN> 
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 59994100EC1C6
	for <linux-nvdimm@lists.01.org>; Wed,  6 Jan 2021 10:27:06 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id d37so3686217ybi.4
        for <linux-nvdimm@lists.01.org>; Wed, 06 Jan 2021 10:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=eeC2fi1+jvD9Jaohf4NuwwFJrgFWz6stCiDxUJb7oJk=;
        b=Mphlcus5YIqP/Zfedgjh7CzYOf5Ydn+wUXZznXru+FNYbYfjEaPGiq+1cKGjTnR+6N
         3675fG23e+MX+g+eDR8smRTT6Il1yjt+iVYoUmkLgvWifStyGU99VIc079Q9JhDBLhIg
         G+v5dtOB4c2R0oQ7uexLZPo8MWZnKfrpoiJ8+qjoJqnpxHddFeQLWq3bIv/aSzlUYIdf
         yE5U+BgwnwW7WvYW/EEprK735V3oUE4e9zP/6xzdG91+La3ziaO2SpY7E5xixmd40+oc
         //ZIFx/QHn4rB6ts1pAU0xRABM2x4trhREz2Jzq/+momLZU5SoSH8muLLsyiXny6C203
         bdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=eeC2fi1+jvD9Jaohf4NuwwFJrgFWz6stCiDxUJb7oJk=;
        b=hjhy3CyA0qQp3bpsoGTNDHH3ObxBn/2GrX3lzCOF8FVK9E0vaaYx7MOey7242SPzkA
         BUyTUfmdYsCove79CbqvKE0yUCJ9OVqnN054RBYOdR2vgKzv8uX1/PQMZM2BNIKW1d0S
         Y+/x4vjIzg9hpiUe7mVVbF+Zq2cWfy7J+Ev9fvhJGqRkygDf2LIK/OB0LGlguap+KH9t
         +uVeNNhyG+W2KLiVCPpNjmZBIqu8A2edj7fNZkh8SM0PLe1JcqylgraS4uo2kxDd+udF
         E9m+uDik7pvq9FfxHJaNcO8WJ/aOC4lTmYJjJIzbqF2VJvwSl/VOcLwS8dzdsUKLJvux
         TfZw==
X-Gm-Message-State: AOAM5332q4in5J3OtZP/SPB+aRF0BZGO9qc1wDm40NSFhEH7loBCPb03
	DeASnxYnaeRBqGzULTUNA83cK/ae4F9pnLqm1bE=
X-Google-Smtp-Source: ABdhPJzAVw+eI460UCNMHDhnlY5hM4f9c648a8b87WXGuZUlMmBdvTAMMAi8McRB/LXkMJNvsn2LwCH7oAlN/lA8G3s=
X-Received: by 2002:a05:6902:527:: with SMTP id y7mr8183745ybs.398.1609957624750;
 Wed, 06 Jan 2021 10:27:04 -0800 (PST)
MIME-Version: 1.0
From: Elisabeth Peter <ruelskiirr@gmail.com>
Date: Wed, 6 Jan 2021 19:26:19 +0100
Message-ID: <CAFSJe30VXHtjLnxthAW-_WiUOJGUyg6M5si8Jmy0qmwRNqcw3g@mail.gmail.com>
Subject: Hello dear friend
To: undisclosed-recipients:;
Message-ID-Hash: XMQUULX5YRF633YNWWWBBTDOTDRI3BMH
X-Message-ID-Hash: XMQUULX5YRF633YNWWWBBTDOTDRI3BMH
X-MailFrom: ruelskiirr@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: mrselisabethpeter07@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XMQUULX5YRF633YNWWWBBTDOTDRI3BMH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello dear friend

Calvary Greetings in the name of the LORD Almighty and Our LORD the giver
of every good thing. Good day and compliments of the seasons, i know this
letter will definitely come to you as a huge surprise, but I implore you to
take the time to go through it carefully as the decision you make will go
off a long way to determine my future and continued existence.

I am Mrs Elisabeth Peter aging widow of 51 years old suffering from long
time illness.I have some funds I inherited from my late husband, the sum of
($17.9Million Dollars) and I needed a very honest and God fearing  who can
withdraw this money then use the funds for Charity works. I WISH TO GIVE
THIS FUNDS TO YOU FOR CHARITY WORKS. I found your email address from the
internet after honest prayers  to the LORD to bring me a helper and i
decided to contact you if you may be willing and interested to handle these
trust funds in good faith before anything happens to me.

I will appreciate your utmost confidentiality and trust in this matter to
accomplish my heart desire, as I don't want anything that will jeopardize
my last wish. I want you to take 25 percent of the total money for your
personal use while 75% of the money will go to charity.

Any delay in your reply may give me room to look for another good person
for this same purpose. Please assure me that you will act accordingly as I
stated herein. I don't need any telephone communication in this regard
because of my ill-health.

kindly respond quickly for further details.

Regards,
Mrs Elisabeth Peter
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
