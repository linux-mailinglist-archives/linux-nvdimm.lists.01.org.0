Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9CA2A9680
	for <lists+linux-nvdimm@lfdr.de>; Fri,  6 Nov 2020 13:54:44 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6F09B167586BF;
	Fri,  6 Nov 2020 04:54:42 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::242; helo=mail-lj1-x242.google.com; envelope-from=dipanane@gmail.com; receiver=<UNKNOWN> 
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D7305167586BB
	for <linux-nvdimm@lists.01.org>; Fri,  6 Nov 2020 04:54:38 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id 23so1244915ljv.7
        for <linux-nvdimm@lists.01.org>; Fri, 06 Nov 2020 04:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=eRttCBI47DQZ/LxBtyVHxygJNTRaV36pz9Xj6QCdU0A=;
        b=nukeqGoqifBf8b3ryJfA+ssMinMKcbl2MWoczOelmPZeP23qsSz+1yIgtGPvchd2Q7
         6evbY5EIsc/rR5fVyrTO4fmRojBig5l+mmtPJmdhEypUgfikw6dFQL1fjkyPZ2ZtI92r
         vrG/eL/r+QB2n9URHC+88DYrZtGGemtY7a5J1miAD3JNWZswirAZLXpQWWVYprtb1+W7
         Am6/V4zoHn1f7ZjAZ+WrvEzUhB1Nk8EVkeIDqcpPQYtqfA161su9RQ2fhf+Syz+6+Yz+
         uA17zNqYiZOrOR+LBdYjkoxU7w4gJCaPNm3m3Bl52cpyalEWAVtdySs7A2JjlhnQ9+Ak
         JaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=eRttCBI47DQZ/LxBtyVHxygJNTRaV36pz9Xj6QCdU0A=;
        b=MCVoebYa1ZqUHXfaLXA/4FleKT3ESFYAa7HK1Fg9O8wN6LYgOJJjaiI/DmgmCmlX7R
         IfpKojjSR62mEaqeSCi2ghHWq9ceAeoY+0Kj6J826PZsuGy9EwS71IHkMMWkzpGK8OV5
         igA4xUj6KKjORkGBKX/iUBhA2NI728xpZaIN4gXxXYdsrHi9jihjlJjGCz1rO+wl/Vn+
         qSljUvJ4teJ4URMF16C+z7zRkS0rPGA28aWqixnvZLun2vx83H1ta8LHwd2RXJgiBOmW
         Q8R34MlV3M35fgXz+VZqUJkBdFIBZ/G7MzskeVRuqiRYeOllX3sVJ99KXVzOP814gesN
         7I8A==
X-Gm-Message-State: AOAM531Xt1ayQRyo8UfkVQ+j96u3TD261I3lVV1rb99Hvqw99z0dfws7
	YU6cuRQqBqpG0SeRnu8Hs0sLGhqP6TLbfnfO8Hw=
X-Google-Smtp-Source: ABdhPJxGeslL/Y4Suh8kVRpoELzz3HHO2scYF+SBMwKnFbr6nvlQ2EmC5AD5imvTT+RTdBnLDsQCacUw8e/i47fJ4GI=
X-Received: by 2002:a2e:b8c7:: with SMTP id s7mr664636ljp.374.1604667275842;
 Fri, 06 Nov 2020 04:54:35 -0800 (PST)
MIME-Version: 1.0
From: Daniel SACKEY <ddsckey@gmail.com>
Date: Fri, 6 Nov 2020 20:54:25 +0800
Message-ID: <CAME6GFDt_aY6xrrMEOqp2781ajrwV_932Nd3Kmc_NNYG6-ydWQ@mail.gmail.com>
Subject: re
To: undisclosed-recipients:;
Message-ID-Hash: I75GOG46IAFJYABNIBDEURPWBHOF3QDJ
X-Message-ID-Hash: I75GOG46IAFJYABNIBDEURPWBHOF3QDJ
X-MailFrom: dipanane@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: ddsckey@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/I75GOG46IAFJYABNIBDEURPWBHOF3QDJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

 Good morning and how are you,

This message might meet you in utmost surprise. However, it is my urgent
need for a foreign partner that made me contact you for this transaction. I
am Mr Daniel Sackey, Managing Director of Ecobank over here in Accra,
Ghana.  On 15th July 2009 one of my bank customers died along with his
entire family in a plane crash in Northern Iran, but before his death, he
made a fixed deposit of $12,500,000.00 with our bank unfortunately, the
deceased did not attach to the fund any next of kin. Since there is no next
of kin to the fund, I want to put your  information into our bank database
as the legal next of kin to the fund and the money would be legally
transferred to you.  I want you to help me receive the fund in your country
or any country of your choice because I cannot do this deal alone except
with a foreign partner. This business is legal, and we shall follow all the
legal banking procedures for the money to be transferred to you legally.

We shall share the money equally; 50/50 percent each after it has been
transferred to you. If you agree to my business deal, more details relating
to the fund transfer and vital legal documents concerning this deal will be
forwarded to you for more clarifications as soon as I receive your reply.
Please treat this transaction very confidential.

Sincerely
Mr. Daniel Sackey
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
